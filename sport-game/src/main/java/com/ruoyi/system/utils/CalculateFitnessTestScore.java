package com.ruoyi.system.utils;

import com.ruoyi.system.domain.FitnessTestScore;
import com.ruoyi.system.mapper.FitnessTestScoreStanderMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.util.HashMap;
import java.util.Map;

/**
 * @program: Ruoyi-Vue
 * @description: 体测成绩计算工具
 * @author: LeftHand
 * @create: 2022-12-12 13:02
 **/
@Component
public class CalculateFitnessTestScore {
    // 男
    private final int GENDER_MAN = 0;
    // 女
    private final int GENDER_WOMAN = 1;

    // 大一、二
    private static final String GRADE_FRESHMAN = "1-2";

    // 大三、四
    private static final String GRADE_SENIOR = "3-4";

    // 专升本和二学位
    private static final String GRADE_OTHER = "3-4";

    @Autowired
    private FitnessTestScoreStanderMapper stander;

    public static String getGrade(int g) {
        switch (g) {
            case 1:
            case 2:
                return GRADE_FRESHMAN;
            case 3:
            case 4:
            default: return GRADE_SENIOR;
        }
    }

    /**
     * @Description: 计算50米成绩
     * @Param:
     * @return:
     * @Author: leftHand
     * @Date: 2022-11-04
     */
    public int fifRun(Long gender, Float score, int grade) {
        if (score == null) {
            return 0;
        }
        Integer singleScore = stander.Cal50RunScore(Double.valueOf(score), getGrade(grade), gender == 0L ? GENDER_MAN : GENDER_WOMAN);
        return singleScore == null ? 0 :singleScore;
    }

    /**
     * @Description: 长跑合格情况
     * @Param:
     * @return:
     * @Author: leftHand
     * @Date: 2022-11-04
     */
    public int longRun (Long gender, Float score, int grade) {
        if (score == null) {
            return 0;
        }
        Integer singleScore = stander.CalLongRunScore(Double.valueOf(score), getGrade(grade), gender == 0L ? GENDER_MAN : GENDER_WOMAN);
        return singleScore == null ? 0 :singleScore;
    }

    /**
     * @Description: 体前屈合格情况
     * @Param:
     * @return:
     * @Author: leftHand
     * @Date: 2022-11-04
     */
    public int flex(Long gender, Float score, int grade) {
        if (score == null) {
            return 0;
        }
        Integer singleScore = stander.CalFlexScore(Double.valueOf(score), getGrade(grade), gender == 0L ? GENDER_MAN : GENDER_WOMAN);
        return singleScore == null ? 0 :singleScore;
    }

    /**
     * @Description: 附加项目合格情况
     * @Param:
     * @return:
     * @Author: leftHand
     * @Date: 2022-11-04
     */
    public int other (Long gender, Integer score, int grade) {
        if (score == null) {
            return 0;
        }
        Integer singleScore = stander.CalOtherScore(Double.valueOf(score), getGrade(grade), gender == 0L ? GENDER_MAN : GENDER_WOMAN);
        return singleScore == null ? 0 :singleScore;
    }

    /**
     * @Description: 肺活量合格情况
     * @Param:
     * @return:
     * @Author: leftHand
     * @Date: 2022-11-04
     */
    public int lung (Long gender, Integer score, int grade) {
        if (score == null) {
            return 0;
        }
        Integer singleScore = stander.CalLungScore(Double.valueOf(score), getGrade(grade), gender == 0L ? GENDER_MAN : GENDER_WOMAN);
        return singleScore == null ? 0 :singleScore;
    }

    /**
     * @Description: 立定跳合格情况
     * @Param:
     * @return:
     * @Author: leftHand
     * @Date: 2022-11-04
     */
    public int jump (Long gender, Integer score, int grade) {
        if (score == null) {
            return 0;
        }
        Integer singleScore = stander.CalJumpScore(Double.valueOf(score), getGrade(grade), gender == 0L ? GENDER_MAN : GENDER_WOMAN);
        return singleScore == null ? 0 :singleScore;
    }

    public int bmi(Integer height, Integer weight, Long gender, int grade) {
        if (height == null || weight == null) return 0;
        double v = weight * 10000.0 / (height * height);
        double nomal, fat, realFat;


        if (gender == 0) {
            nomal = 17.9;
            fat = 24.0;
            realFat = 28;
        } else {
            nomal = 17.2;
            fat = 24.0;
            realFat = 28;
        }
        // 低体脂
        if (v < nomal) return 80;
        else if (v < fat) return 100;
        else if (v < realFat) return 80;
        else return 60;


    }

    /**
    * @Description: 计算总成绩
    * @Param:
    * @return:
    * @Author: leftHand
    * @Date: 2022-12-12
    */
    public Map<String, Object> totalScore(Long gender, int grade, FitnessTestScore score) {
        if (gender == null) {
            return null;
        }
        Long height = score.getHeight();
        Long weight = score.getWeight();
        Long longJump = score.getLongJump();
        Long vitalCapacity = score.getVitalCapacity();
        Long otherItem = score.getOtherItem();

        int fifScore = fifRun(gender, score.getFiftyRun(), grade);
        int jumpScore = jump(gender, longJump == null ? 0 : Math.toIntExact(longJump), grade);
        int longRunScore = longRun(gender, score.getEnduranceRunning(), grade);
        int lungScore = lung(gender, vitalCapacity == null ? 0 : Math.toIntExact(vitalCapacity), grade);
        int flexScore = flex(gender, score.getSittingBodyBend(), grade);
        int otherScore = other(gender, otherItem == null ? 0 : Math.toIntExact(otherItem), grade);
        int bmiScore = 0;
        if (height != null && weight != null) {
            bmiScore = bmi(score.getHeight().intValue(), score.getWeight().intValue(), gender, grade);
        }
        Map<String, Object> result = new HashMap<>();
        result.put("fifScore", fifScore);
        result.put("jumpScore", jumpScore);
        result.put("longRunScore", longRunScore);
        result.put("lungScore", lungScore);
        result.put("otherScore", otherScore);
        result.put("bmiScore", bmiScore);

        Double finalScore =
                        bmiScore * 0.15 +
                        lungScore * 0.15 +
                        fifScore * 0.2 +
                        flexScore * 0.1 +
                        jumpScore * 0.1 +
                        otherScore * 0.1 +
                        longRunScore * 0.2;

        result.put("finalScore", finalScore);

        return result;
    }


}
