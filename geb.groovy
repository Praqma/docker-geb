@Grapes([ 
    @Grab("org.codehaus.geb:geb-core:0.7.2"),
    @Grab("org.seleniumhq.selenium:selenium-htmlunit-driver:2.25.0"),
    @Grab("org.seleniumhq.selenium:selenium-support:2.25.0"),
    @Grab("org.seleniumhq.selenium:selenium-firefox-driver:2.25.0")
])

import geb.Browser
import org.openqa.selenium.firefox.FirefoxDriver

Browser.drive() {
    go "http://www.praqma.com"
    assert $(".site-header .phone").text() == "+45 36772 762";
    assert $(".site-header .phone").text() == "WRONG";
}
