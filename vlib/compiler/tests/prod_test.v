// Build and run files in ./prod/ folder, comparing their output to *.expected.txt files.
// (Similar to REPL tests, but in -prod mode.)

// import os
import compiler.tests.repl.runner
import benchmark

fn test_all_v_prod_files() {
	// TODO: Fix running this test on Windows:
	$if !windows {
		options := runner.new_prod_options()
		mut bmark := benchmark.new_benchmark()
		for file in options.files {
			// println('file:$file')
			bmark.step()
			fres := runner.run_prod_file(options.wd, options.vexec, file) or {
				bmark.fail()
				eprintln( bmark.step_message(err) )
				assert false
				continue
			}
			bmark.ok()
			println( bmark.step_message(fres) )
			assert true
		}
		bmark.stop()
		println( bmark.total_message('total time spent running PROD files') )
	}
}
