package com.pullreports.commontest;

import static org.junit.Assert.assertTrue;

import org.junit.AfterClass;
import org.junit.BeforeClass;
import org.junit.Test;
import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.chrome.ChromeDriver;
import org.openqa.selenium.support.ui.ExpectedConditions;
import org.openqa.selenium.support.ui.WebDriverWait;

/**
 * Common test methods for verifying common behavior
 * across the different example Pull Reports installations.
 */
public abstract class AbstractBasicBehaviorTest {

    protected static WebDriver driver;

    @BeforeClass
    public static void setUpDriver(){
        driver = new ChromeDriver();
    }

    @AfterClass
    public static void tearDownDriver(){
        driver.quit();
    }
    
    protected abstract String getBaseUrl();
    protected abstract String getReportCreatorPath();
    
    @Test
    public void testWelcomePage() {
        driver.get(getBaseUrl());
        WebElement welcomeHeader = new WebDriverWait(driver, 10)
            .until(ExpectedConditions.presenceOfElementLocated(By.cssSelector("h1")));
        assertTrue(welcomeHeader.getText().matches("Pet Store.*Demonstration"));
    }

    @Test
    public void testReportRepository() {
        driver.get(getBaseUrl() + getReportCreatorPath());
        WebElement reportLink = new WebDriverWait(driver, 10)
            .until(ExpectedConditions.presenceOfElementLocated(By.cssSelector("h4 a")));
        assertTrue(reportLink.getText().matches("Item Report"));
    }
    
    @Test
    public void testReportCreatorTableMode() {
        driver.get(getBaseUrl() + getReportCreatorPath() + "?catalogId=petstore&reportId=items");

        new WebDriverWait(driver, 10)
            .until(ExpectedConditions.presenceOfElementLocated(
                    By.cssSelector("#pr-preview-table tbody")));

        WebElement previewTable = new WebDriverWait(driver, 10)
            .until(ExpectedConditions.presenceOfElementLocated(
                    By.cssSelector("#pr-preview-table")));

        WebElement columnHeader = previewTable.findElement(
                By.cssSelector("thead tr:nth-child(2) th:first-child"));

        assertTrue(columnHeader.getAttribute("innerHTML").contains("Item ID"));

        int numberOfRows = previewTable.findElements(
                By.cssSelector("tbody tr")).size();

        assertTrue(numberOfRows > 1);
    }
}
