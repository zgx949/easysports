package com.ruoyi.sport.game.service.impl;

import com.alibaba.fastjson2.JSON;
import com.ruoyi.common.core.domain.Dict;
import com.ruoyi.system.domain.FitnessTestBaseInfo;
import com.ruoyi.system.domain.FitnessTestScore;
import com.ruoyi.system.domain.SportGames;
import com.ruoyi.system.mapper.FitnessTestBaseInfoMapper;
import com.ruoyi.system.mapper.FitnessTestScoreMapper;
import com.ruoyi.system.mapper.FitnessTestScoreStanderMapper;
import com.ruoyi.system.mapper.SportGamesMapper;
import com.ruoyi.system.utils.CalculateFitnessTestScore;
import org.junit.jupiter.api.Test;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import javax.annotation.Resource;
import java.util.List;
import java.util.Map;

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

    @Resource
    private CalculateFitnessTestScore calculator;

    @Resource
    private FitnessTestScoreMapper scoreMapper;
    @Resource
    private FitnessTestBaseInfoMapper infoMapper;

    @Autowired
    private static final Logger logger = LoggerFactory.getLogger("sys-user");


    @Test
    public void selectSportGamesDictTest() {
        List<Dict> dict = sportGamesMapper.selectSportGamesDict();

        System.out.println(dict);
    }

    @Test
    public void selectSportGamesListTest() {
        FitnessTestScore condition = new FitnessTestScore();
        condition.setRemark("无个人年级信息");
        List<FitnessTestScore> scores = scoreMapper.selectFitnessTestScoreList(condition);
        for (FitnessTestScore score : scores) {
            FitnessTestBaseInfo user = infoMapper.selectBaseInfoByUserId(score.getUserId());
            FitnessTestScore updateData = new FitnessTestScore();
            updateData.setId(score.getId());

            if (user == null) {
                logger.info("无个人信息 -> 学号：{}", score.getUserId());
                updateData.setRemark("无个人基本信息, 无法计算成绩");
                scoreMapper.updateFitnessTestScore(updateData);
                continue;
            }

            String grade = score.getGrade();
            if (grade == null || grade.equals("")) {
                updateData.setRemark("无个人年级信息");
                scoreMapper.updateFitnessTestScore(updateData);
                logger.info("无年级信息 -> 学号：{}", score.getUserId());
                continue;
            }

            Map<String, Object> mp = calculator.totalScore(user.getSex(), Integer.parseInt(grade), score);
            if (mp != null) {
                String finalScore = String.format("%.2f", (Double) mp.get("finalScore"));
                logger.info("学号：{}，性别：{}， 年级：{} -> {}",
                        user.getUserId(),
                        user.getSex(),
                        score.getGrade(),
                        finalScore
                );
                updateData.setRemark(finalScore);
                scoreMapper.updateFitnessTestScore(updateData);
            } else {
                updateData.setRemark("信息缺失");
                scoreMapper.updateFitnessTestScore(updateData);
                logger.info("信息缺失 -> 学号：{}", score.getUserId());
            }
        }

    }

}
