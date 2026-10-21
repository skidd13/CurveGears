"""An invalid-input fixture must fail at its declared assertion boundary."""
from pathlib import Path
import tempfile
import unittest
from unittest.mock import patch
from utils.regression import check


class InvalidDiagnosticTests(unittest.TestCase):
    def setUp(self):
        self.temp=tempfile.TemporaryDirectory();self.addCleanup(self.temp.cleanup)
        self.root=Path(self.temp.name);self.build=self.root/'build/regression'
        self.source=self.root/'tests/circle/invalid_probe.scad'
        self.source.parent.mkdir(parents=True)
        self.source.write_text('// @regression: expected-assertion intended guard\nassert(false);')
        self.marker=self.build/'invalid/circle/invalid_probe.failed'
        self.marker.parent.mkdir(parents=True);self.marker.touch()
        self.log=self.marker.with_suffix('.log')
        for name,value in [('ROOT',self.root),('BUILD',self.build)]:
            patcher=patch.object(check,name,value);patcher.start();self.addCleanup(patcher.stop)

    def run_log(self,text):
        self.log.write_text(text)
        return check.check_invalid(['circle'])

    def test_declared_assertion_is_recorded(self):
        rows=self.run_log('ERROR: Assertion false failed: "intended guard" in file guard.scad, line 1\n')
        self.assertEqual(['intended guard'],rows[0]['diagnostics'])

    def test_unrelated_assertion_cannot_pass_via_echoed_token(self):
        with self.assertRaises(AssertionError):
            self.run_log('ECHO: "intended guard"\nERROR: Assertion false failed: "wrong guard" in file wrong.scad, line 2\n')

    def test_warnings_parser_errors_and_non_assertion_errors_fail(self):
        for text in ['WARNING: missing import\nERROR: Assertion false failed: "intended guard" in file guard.scad\n',
                     'Parser error: intended guard\n', 'ERROR: crash: intended guard\n', '',
                     'ERROR: Assertion false failed: "intended guard" in file guard.scad\nERROR: another failure\n']:
            with self.subTest(text=text),self.assertRaises(AssertionError):self.run_log(text)

    def test_missing_or_ambiguous_source_expectation_fails(self):
        for source in ['assert(false);', '// @regression: expected-assertion intended guard\n// @regression: expected-assertion another guard\n']:
            self.source.write_text(source)
            with self.assertRaises(AssertionError):
                self.run_log('ERROR: Assertion false failed: "intended guard" in file guard.scad\n')
