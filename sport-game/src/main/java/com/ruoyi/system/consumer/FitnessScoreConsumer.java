package com.ruoyi.system.consumer;

import com.alibaba.fastjson2.JSON;
import com.alibaba.fastjson2.JSONArray;
import com.alibaba.fastjson2.JSONObject;
import com.ruoyi.system.domain.FitnessTestScore;
import com.ruoyi.system.service.impl.FitnessTestScoreServiceImpl;
import lombok.extern.slf4j.Slf4j;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.amqp.rabbit.annotation.RabbitListener;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

/**
 * @program: Ruoyi-Vue
 * @description: 成绩信息消费者
 * @author: LeftHand
 * @create: 2022-11-08 22:03
 **/
@Slf4j
@Service
public class FitnessScoreConsumer {
    private static final Logger logger = LoggerFactory.getLogger("sys-user");

    @Autowired
    private FitnessTestScoreServiceImpl fitnessTestScoreService;
    /**
     * 批量插入数据
     *
     * @param
     */
    @RabbitListener(queues = "topicExchange")
    public void consumerExistsQueue(List<FitnessTestScore> fitnessTestScores) {
        logger.info("异步消息 -> 成绩录入：{}条", fitnessTestScores.size());

        int successCount = fitnessTestScoreService.insertFitnessTestScoreList(fitnessTestScores);
        if(successCount != fitnessTestScores.size()){
            logger.warn("异步消息反馈: 录入成绩数与传入成绩数不符");
        } else {
            logger.info("异步消息反馈: 全部成绩录入成功");
        }

    }
}
