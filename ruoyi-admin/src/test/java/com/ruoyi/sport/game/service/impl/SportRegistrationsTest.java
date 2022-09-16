package com.ruoyi.sport.game.service.impl;

import com.ruoyi.system.domain.SportRegistrations;
import com.ruoyi.system.mapper.SportRegistrationsMapper;
import com.ruoyi.system.service.impl.SportRegistrationsServiceImpl;
import org.junit.jupiter.api.Test;
import org.springframework.boot.test.context.SpringBootTest;

import javax.annotation.Resource;
import java.util.List;

/**
 * @program: Ruoyi-Vue
 * @description: Registration test
 * @author: LeftHand
 * @create: 2022-07-08 15:47
 **/
@SpringBootTest
public class SportRegistrationsTest {

    @Resource
    private SportRegistrationsMapper sportRegistrationsMapper;
    @Resource
    private SportRegistrationsServiceImpl sportRegistrationsService;

    @Test
    public void selectSportRegistrationsList() {
        List<SportRegistrations> sportRegistrations = sportRegistrationsMapper.selectSportRegistrationsList(null);
        for (SportRegistrations sportRegistration : sportRegistrations) {
            System.out.println(sportRegistration);
        }
    }

    @Test
    public void word() {
//        String xml = sportRegistrationsService.getDeptRegister(210);
//        String xml = sportRegistrationsService.wordGeneration();
        String xml = sportRegistrationsService.getTimeOrder();
        System.out.println(xml);
    }



}
