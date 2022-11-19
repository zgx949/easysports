package com.ruoyi.sport.game.service.impl;

import com.ruoyi.system.domain.SportRegistrations;
import com.ruoyi.system.mapper.SportRegistrationsMapper;
import com.ruoyi.system.service.impl.SportRegistrationsServiceImpl;
import com.ruoyi.system.utils.WordUtils;
import org.junit.jupiter.api.Test;
import org.springframework.amqp.rabbit.core.RabbitTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import javax.annotation.Resource;
import java.io.*;
import java.util.HashMap;
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
    public void word() throws IOException {
//        String xml = sportRegistrationsService.getDeptRegister(210);
//        String xml = sportRegistrationsService.wordGeneration();
        String xml = sportRegistrationsService.wordGeneration();


//        FileUtils.writeBytes("C:\\Users\\Administrator\\Desktop\\模板\\1.doc", in_nocode);
        WordUtils.fileWriterMethod("C:\\Users\\Administrator\\Desktop\\模板\\1.doc", xml);
//        System.out.println(xml);

    }

    @Test
    public void groupWord() throws IOException {
        HashMap<String, String> mp = new HashMap<>();
        //代表队模板
        mp.put("depthReport", "");
        // 竞赛日程模板
        mp.put("gamesOrders", "");
        // 竞赛分组模板
        String gamesGroups = sportRegistrationsService.getGroupDetail();
        mp.put("gamesGroups", gamesGroups);

        String xml = WordUtils.process(mp, "/vm/sportMeeting/template.ftl").toString();

        WordUtils.fileWriterMethod("C:\\Users\\Administrator\\Desktop\\模板\\1.doc", xml);

    }

    @Autowired
    private RabbitTemplate rabbitTemplate;
    @Test
    public void sendMsg() {
        rabbitTemplate.convertAndSend("topicExchange","{\"test\":0}");
    }



}
