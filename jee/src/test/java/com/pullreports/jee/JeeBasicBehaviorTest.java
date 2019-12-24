package com.pullreports.jee;

import com.pullreports.commontest.AbstractBasicBehaviorTest;

public class JeeBasicBehaviorTest extends AbstractBasicBehaviorTest{

    private static String BASE_URL = "http://localhost:8080";
    private static String REPORT_CREATOR_URL = "/adHocCreator";

    @Override
    protected String getBaseUrl() {
       return BASE_URL; 
    }
    @Override
    protected String getReportCreatorPath() {
        return REPORT_CREATOR_URL;
    }
}