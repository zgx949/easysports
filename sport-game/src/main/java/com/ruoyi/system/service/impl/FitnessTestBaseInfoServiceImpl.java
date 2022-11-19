package com.ruoyi.system.service.impl;

import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.TimeUnit;

import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.common.core.redis.RedisCache;
import com.ruoyi.common.utils.sign.Md5Utils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.ruoyi.system.mapper.FitnessTestBaseInfoMapper;
import com.ruoyi.system.domain.FitnessTestBaseInfo;
import com.ruoyi.system.service.IFitnessTestBaseInfoService;
import org.springframework.util.ObjectUtils;

/**
 * 用户信息Service业务层处理
 *
 * @author leftHand
 * @date 2022-10-17
 */
@Service
public class FitnessTestBaseInfoServiceImpl implements IFitnessTestBaseInfoService
{
    @Autowired
    private FitnessTestBaseInfoMapper fitnessTestBaseInfoMapper;

    @Autowired
    private RedisCache redisCache;
    /**
     * 查询用户信息
     *
     * @param id 用户信息主键
     * @return 用户信息
     */
    @Override
    public FitnessTestBaseInfo selectFitnessTestBaseInfoById(Long id)
    {
        return fitnessTestBaseInfoMapper.selectFitnessTestBaseInfoById(id);
    }

    /**
     * 查询用户信息列表
     *
     * @param fitnessTestBaseInfo 用户信息
     * @return 用户信息
     */
    @Override
    public List<FitnessTestBaseInfo> selectFitnessTestBaseInfoList(FitnessTestBaseInfo fitnessTestBaseInfo)
    {
        return fitnessTestBaseInfoMapper.selectFitnessTestBaseInfoList(fitnessTestBaseInfo);
    }

    /**
     * 新增用户信息
     *
     * @param fitnessTestBaseInfo 用户信息
     * @return 结果
     */
    @Override
    public int insertFitnessTestBaseInfo(FitnessTestBaseInfo fitnessTestBaseInfo)
    {
        return fitnessTestBaseInfoMapper.insertFitnessTestBaseInfo(fitnessTestBaseInfo);
    }

    /**
     * 修改用户信息
     *
     * @param fitnessTestBaseInfo 用户信息
     * @return 结果
     */
    @Override
    public int updateFitnessTestBaseInfo(FitnessTestBaseInfo fitnessTestBaseInfo)
    {
        return fitnessTestBaseInfoMapper.updateFitnessTestBaseInfo(fitnessTestBaseInfo);
    }

    /**
     * 批量删除用户信息
     *
     * @param ids 需要删除的用户信息主键
     * @return 结果
     */
    @Override
    public int deleteFitnessTestBaseInfoByIds(Long[] ids)
    {
        return fitnessTestBaseInfoMapper.deleteFitnessTestBaseInfoByIds(ids);
    }

    /**
     * 删除用户信息信息
     *
     * @param id 用户信息主键
     * @return 结果
     */
    @Override
    public int deleteFitnessTestBaseInfoById(Long id)
    {
        return fitnessTestBaseInfoMapper.deleteFitnessTestBaseInfoById(id);
    }

    /**
     * 通过学号集合查询用户信息集合
     * @param userIds
     * @return
     */
    @Override
    public List<FitnessTestBaseInfo> selectBaseInfoByUserIds(List<String> userIds) {
        // 如果缓存已有数据
        String hash = Md5Utils.hash(userIds.toString());
        List<FitnessTestBaseInfo> cacheObject = redisCache.getCacheObject(String.format("qrCodeCache:%s", hash));
        // 缓存存在，并且第一个学号和缓存一致（防止哈希冲突问题）
        if (cacheObject != null && cacheObject.size() > 0 && cacheObject.get(0).getUserId().equals(userIds.get(0))) {
            return cacheObject;
        }

        List<FitnessTestBaseInfo> fitnessTestBaseInfos=new ArrayList<>();
        for(String userId:userIds){
            FitnessTestBaseInfo fitnessTestBaseInfo = fitnessTestBaseInfoMapper.selectBaseInfoByUserId(userId);
            if(ObjectUtils.isEmpty(fitnessTestBaseInfo)){//如果未查询到该用户信息，则仅返回学号
                FitnessTestBaseInfo unKnowFitnessTestBaseInfo=new FitnessTestBaseInfo();
                unKnowFitnessTestBaseInfo.setUserId(userId);
                fitnessTestBaseInfos.add(unKnowFitnessTestBaseInfo);
            }else {
                fitnessTestBaseInfos.add(fitnessTestBaseInfo);
            }
        }
        // 缓存
        redisCache.setCacheObject(String.format("qrCodeCache:%s", hash), fitnessTestBaseInfos, 12,TimeUnit.HOURS);
        return fitnessTestBaseInfos;
    }
}
