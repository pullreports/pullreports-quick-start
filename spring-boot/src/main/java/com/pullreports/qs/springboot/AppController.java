package com.pullreports.qs.springboot;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class AppController {

    @GetMapping("/")
    public String index() {
        return "index";
    }

    @GetMapping("/adHocCreator")
    public String adHocCreator() {
        return "ad-hoc-creator";
    }

    @GetMapping("/itemLookup")
    public String itemLookup() {
        return "item-lookup";
    }
}
