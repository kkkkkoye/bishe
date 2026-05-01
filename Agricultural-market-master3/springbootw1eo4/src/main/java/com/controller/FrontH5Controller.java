package com.controller;

import com.annotation.IgnoreAuth;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * 微信小程序 H5 前端入口
 * 将 /front 根路径重定向到 H5 index.html
 */
@Controller
@RequestMapping("/front")
public class FrontH5Controller {

    @IgnoreAuth
    @GetMapping(value = {"", "/", "/h5", "/h5/"})
    public void index(HttpServletResponse response) throws IOException {
        response.sendRedirect("/springbootw1eo4/front/h5/index.html");
    }
}
