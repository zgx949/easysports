package com.ruoyi.sport.game.service.impl;

import com.ruoyi.framework.web.service.SysLoginService;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;

import javax.annotation.Resource;

/**
 * @program: Ruoyi-Vue
 * @description: 登录测试
 * @author: LeftHand
 * @create: 2022-09-23 11:15
 **/
public class LoginTest {
//    @Autowired
//    private SysLoginService loginService;
    @Test
    public void loginTest () {
        SysLoginService loginService = new SysLoginService();
        System.out.println(loginService.login("admin", "admin123", null, null));
    }
}
