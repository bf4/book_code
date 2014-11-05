<?php
require('kelvinator.php');
?>

<?php  ?>
<?php
class KelvinatorSteps extends CucumberSteps {
    // Your step definitions will go here

    /**
    * Given /^a temperature of (\d+) degrees centigrade$/ <label id="code.php.regex"/>
    **/
    public function stepATemperatureOfDegreesCentigrade($centigrade) { 
        $this->aGlobals['centigrade'] = $centigrade; 
    }

    /**
     * When /^I convert it to Kelvin$/
     **/
    public function stepIConvertItToKelvin() {
        $this->aGlobals['kelvin'] = kelvinate(
            $this->aGlobals['centigrade']);
    }

    /**
     * Then /^the result should be (\d+) degrees Kelvin$/
     **/
    public function stepTheResultShouldBe3DegreesKelvin($expected) {
        self::assertEquals($this->aGlobals['kelvin'], $expected); 
    }

}
?>
<?php  ?>
