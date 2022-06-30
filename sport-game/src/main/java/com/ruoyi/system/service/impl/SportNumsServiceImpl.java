package com.ruoyi.system.service.impl;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.ruoyi.system.mapper.SportNumsMapper;
import com.ruoyi.system.domain.SportNums;
import com.ruoyi.system.service.ISportNumsService;

/**
 * 号码段管理Service业务层处理
 * 
 * @author ruoyi
 * @date 2022-06-30
 */
@Service
public class SportNumsServiceImpl implements ISportNumsService 
{
    @Autowired
    private SportNumsMapper sportNumsMapper;

    /**
     * 查询号码段管理
     * 
     * @param id 号码段管理主键
     * @return 号码段管理
     */
    @Override
    public SportNums selectSportNumsById(Long id)
    {
        return sportNumsMapper.selectSportNumsById(id);
    }

    /**
     * 查询号码段管理列表
     * 
     * @param sportNums 号码段管理
     * @return 号码段管理
     */
    @Override
    public List<SportNums> selectSportNumsList(SportNums sportNums)
    {
        return sportNumsMapper.selectSportNumsList(sportNums);
    }

    /**
     * 新增号码段管理
     * 
     * @param sportNums 号码段管理
     * @return 结果
     */
    @Override
    public int insertSportNums(SportNums sportNums)
    {
        return sportNumsMapper.insertSportNums(sportNums);
    }

    /**
     * 修改号码段管理
     * 
     * @param sportNums 号码段管理
     * @return 结果
     */
    @Override
    public int updateSportNums(SportNums sportNums)
    {
        return sportNumsMapper.updateSportNums(sportNums);
    }

    /**
     * 批量删除号码段管理
     * 
     * @param ids 需要删除的号码段管理主键
     * @return 结果
     */
    @Override
    public int deleteSportNumsByIds(Long[] ids)
    {
        return sportNumsMapper.deleteSportNumsByIds(ids);
    }

    /**
     * 删除号码段管理信息
     * 
     * @param id 号码段管理主键
     * @return 结果
     */
    @Override
    public int deleteSportNumsById(Long id)
    {
        return sportNumsMapper.deleteSportNumsById(id);
    }
}
