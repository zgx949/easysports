package com.ruoyi.sport.game.service.impl;

import com.alibaba.fastjson2.JSON;
import com.ruoyi.common.core.domain.Dict;
import com.ruoyi.system.domain.SportGames;
import com.ruoyi.system.mapper.SportGamesMapper;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import javax.annotation.Resource;
import java.util.List;

/**
 * @program: Ruoyi-Vue
 * @description: Games test
 * @author: LeftHand
 * @create: 2022-07-08 14:43
 **/
@SpringBootTest
public class SportGamesImlTest {

    @Resource
    private SportGamesMapper sportGamesMapper;


    @Test
    public void selectSportGamesDictTest() {
        List<Dict> dict = sportGamesMapper.selectSportGamesDict();

        System.out.println(dict);
    }

    @Test
    public void selectSportGamesListTest() {
        List<SportGames> sportGames = sportGamesMapper.selectSportGamesList(null);
        System.out.println(sportGames);
    }
}
