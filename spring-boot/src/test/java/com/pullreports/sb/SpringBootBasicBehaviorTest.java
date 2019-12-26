package com.pullreports.sb;

import com.pullreports.commontest.AbstractBasicBehaviorTest;
import org.junit.BeforeClass;

public class SpringBootBasicBehaviorTest extends AbstractBasicBehaviorTest{

    private static String BASE_URL = "http://localhost:8082";
    private static String REPORT_CREATOR_URL = "/d/adHocCreator";

    @Override
    protected String getBaseUrl() {
       return BASE_URL; 
    }
    @Override
    protected String getReportCreatorPath() {
        return REPORT_CREATOR_URL;
    }
}
