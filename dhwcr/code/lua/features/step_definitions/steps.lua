-- START:given
Given("an empty test plan", function ()
  tests = {}
end)
-- END:given

-- START:when
When("I add a test to measure (%a+)", function (measurement)
  table.insert(tests, measurement)
end)
-- END:when

-- START:then
Then("I should see the following tests:", function (t)
  expected = {}

  table.remove(t, 1)
  for i, row in ipairs(t) do
    table.insert(expected, row[1])
  end

  assert(unpack(expected) == unpack(tests))
end)
-- END:then
