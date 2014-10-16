Then /^the junit output file contains two testsuite elements named 'suite one' and 'suite two'$/ do
  step 'I parse the junit results file'
  @results.xpath("/testsuites/testsuite").size.should == 2
  @results.xpath("/testsuites/testsuite/@name").map(&:text).sort.should == ["spec.suite_one_spec", "spec.suite_two_spec"]
end

Then /^the junit output file has one test against each suite$/ do
  step 'I parse the junit results file'
  @results.xpath("/testsuites/testsuite/@tests").map(&:text).should == ["1", "1"]
end

Then /^the junit output file has the correct test counts against each suite$/ do
  step 'I parse the junit results file'
  #suite one
  @results.at_xpath("/testsuites/testsuite[@name='spec.suite_one_spec']/@tests").value.should == "4"
  @results.at_xpath("/testsuites/testsuite[@name='spec.suite_one_spec']/@failures").value.should == "2"
  @results.at_xpath("/testsuites/testsuite[@name='spec.suite_one_spec']/@skipped").value.should == "1"

  #suite two
  @results.at_xpath("/testsuites/testsuite[@name='spec.suite_two_spec']/@tests").value.should == "6"
  @results.at_xpath("/testsuites/testsuite[@name='spec.suite_two_spec']/@failures").value.should == "1"
  @results.at_xpath("/testsuites/testsuite[@name='spec.suite_two_spec']/@skipped").value.should == "2"
end

Then /^the junit output testsuite element contains a timestamp of each suite$/ do
  step 'I parse the junit results file'
  @results.at_xpath("/testsuites/testsuite[@name='spec.suite_one_spec']/@timestamp").value.should match /\d{4}-\d{2}-\d{2}T\d+:\d+:\d+[\+-]\d+:\d+/
  @results.at_xpath("/testsuites/testsuite[@name='spec.suite_two_spec']/@timestamp").value.should match /\d{4}-\d{2}-\d{2}T\d+:\d+:\d+[\+-]\d+:\d+/
end
