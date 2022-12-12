package com.ruoyi.system.mapper;

import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.springframework.stereotype.Repository;

/**
 * @program: Ruoyi-Vue
 * @description: 根据数据库对照查询体测成绩
 * @author: LeftHand
 * @create: 2022-12-12 13:24
 **/
@Repository
public interface FitnessTestScoreStanderMapper {

    /**
    * @Description: 计算长跑成绩
    * @Param:
    * @return:
    * @Author: leftHand
    * @Date: 2022-12-12
    */
    @Select("SELECT socre FROM `fitness_test_stander` WHERE long_run>=#{score} AND gender=#{gender} AND grade=#{grade} ORDER BY long_run LIMIT 1")
    public Integer CalLongRunScore(@Param("score") Double score, @Param("grade") String grade, @Param("gender") int gender);

    @Select("SELECT socre FROM `fitness_test_stander` WHERE 50m>=#{score} AND gender=#{gender} AND grade=#{grade} ORDER BY long_run LIMIT 1")
    public Integer Cal50RunScore(@Param("score") Double score, @Param("grade") String grade, @Param("gender") int gender);

    @Select("SELECT socre FROM `fitness_test_stander` WHERE lung<=#{score} AND gender=#{gender} AND grade=#{grade} ORDER BY long_run LIMIT 1")
    public Integer CalLungScore(@Param("score") Double score, @Param("grade") String grade, @Param("gender") int gender);

    @Select("SELECT socre FROM `fitness_test_stander` WHERE flex<=#{score} AND gender=#{gender} AND grade=#{grade} ORDER BY long_run LIMIT 1")
    public Integer CalFlexScore(@Param("score") Double score, @Param("grade") String grade, @Param("gender") int gender);

    @Select("SELECT socre FROM `fitness_test_stander` WHERE other<=#{score} AND gender=#{gender} AND grade=#{grade} ORDER BY long_run LIMIT 1")
    public Integer CalOtherScore(@Param("score") Double score, @Param("grade") String grade, @Param("gender") int gender);

    @Select("SELECT socre FROM `fitness_test_stander` WHERE jump<=#{score} AND gender=#{gender} AND grade=#{grade} ORDER BY long_run LIMIT 1")
    public Integer CalJumpScore(@Param("score") Double score, @Param("grade") String grade, @Param("gender") int gender);


}
