# This automatically runs the vows tests
watch('.*\.coffee') {|match| system "jasmine-node --verbose --coffee *.spec.coffee"}
