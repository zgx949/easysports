package com.ruoyi.system.service.impl;

import java.util.Date;
import java.util.List;
import com.ruoyi.common.utils.DateUtils;
import com.ruoyi.common.utils.SecurityUtils;
import com.ruoyi.system.domain.Vo.InsertFitnessTestScoreVo;
import com.ruoyi.system.mapper.FitnessTestBaseInfoMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.ruoyi.system.mapper.FitnessTestScoreMapper;
import com.ruoyi.system.domain.FitnessTestScore;
import com.ruoyi.system.service.IFitnessTestScoreService;
import org.springframework.util.ObjectUtils;

/**
 * 体测成绩Service业务层处理
 * 
 * @author leftHand
 * @date 2022-10-18
 */
@Service
public class FitnessTestScoreServiceImpl implements IFitnessTestScoreService 
{
    @Autowired
    private FitnessTestScoreMapper fitnessTestScoreMapper;

    @Autowired
    private FitnessTestBaseInfoMapper fitnessTestBaseInfoMapper;

    /**
     * 查询体测成绩
     * 
     * @param id 体测成绩主键
     * @return 体测成绩
     */
    @Override
    public FitnessTestScore selectFitnessTestScoreById(Long id)
    {
        return fitnessTestScoreMapper.selectFitnessTestScoreById(id);
    }

    /**
     * 查询体测成绩列表
     * 
     * @param fitnessTestScore 体测成绩
     * @return 体测成绩
     */
    @Override
    public List<FitnessTestScore> selectFitnessTestScoreList(FitnessTestScore fitnessTestScore)
    {
        return fitnessTestScoreMapper.selectFitnessTestScoreList(fitnessTestScore);
    }

    /**
     * 新增体测成绩
     * 
     * @param fitnessTestScore 体测成绩
     * @return 结果
     */
    @Override
    public int insertFitnessTestScore(FitnessTestScore fitnessTestScore)
    {
        fitnessTestScore.setCreateTime(DateUtils.getNowDate());
        return fitnessTestScoreMapper.insertFitnessTestScore(fitnessTestScore);
    }

    /**
     * 修改体测成绩
     * 
     * @param fitnessTestScore 体测成绩
     * @return 结果
     */
    @Override
    public int updateFitnessTestScore(FitnessTestScore fitnessTestScore)
    {
        fitnessTestScore.setUpdateTime(DateUtils.getNowDate());
        return fitnessTestScoreMapper.updateFitnessTestScore(fitnessTestScore);
    }

    /**
     * 批量删除体测成绩
     * 
     * @param ids 需要删除的体测成绩主键
     * @return 结果
     */
    @Override
    public int deleteFitnessTestScoreByIds(Long[] ids)
    {
        return fitnessTestScoreMapper.deleteFitnessTestScoreByIds(ids);
    }

    /**
     * 删除体测成绩信息
     * 
     * @param id 体测成绩主键
     * @return 结果
     */
    @Override
    public int deleteFitnessTestScoreById(Long id)
    {
        return fitnessTestScoreMapper.deleteFitnessTestScoreById(id);
    }

    /**
     * 批量插入体测成绩
     * @param fitnessTestScores
     * @return
     */
    @Override
    public int insertFitnessTestScoreList(List<FitnessTestScore> fitnessTestScores) {
        int successCount=0;
        for(FitnessTestScore fitnessTestScore:fitnessTestScores){
            String userId = fitnessTestScore.getUserId();
            Long isFree = fitnessTestScore.getIsFree();
            if(isFree!=null&&isFree==1){
                fitnessTestScore.setRemark("免测");
            }else {
                fitnessTestScore.setRemark("正常体测");
                fitnessTestScore.setIsFree(0L);
            }
            //查看该学号的用户在体测成绩表中是否有记录
            if(fitnessTestScoreMapper.selectUserIdIsExit(userId)>0){//有则更新
                fitnessTestScore.setUpdateTime(DateUtils.getNowDate());
                fitnessTestScore.setUpdateUid(SecurityUtils.getUserId());
                successCount+=fitnessTestScoreMapper.updateFitnessTestScoreByuserId(fitnessTestScore);
            }else{//无则插入
                fitnessTestScore.setCreateTime(DateUtils.getNowDate());
                fitnessTestScore.setCreateUid(SecurityUtils.getUserId());
                successCount+=fitnessTestScoreMapper.insertFitnessTestScore(fitnessTestScore);
            }
        }
        return successCount;
    }
}
