package com.ruoyi.system.service.impl;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.ruoyi.system.mapper.SportFieldsMapper;
import com.ruoyi.system.domain.SportFields;
import com.ruoyi.system.service.ISportFieldsService;

/**
 * 场地管理Service业务层处理
 * 
 * @author ruoyi
 * @date 2022-06-30
 */
@Service
public class SportFieldsServiceImpl implements ISportFieldsService 
{
    @Autowired
    private SportFieldsMapper sportFieldsMapper;

    /**
     * 查询场地管理
     * 
     * @param id 场地管理主键
     * @return 场地管理
     */
    @Override
    public SportFields selectSportFieldsById(Long id)
    {
        return sportFieldsMapper.selectSportFieldsById(id);
    }

    /**
     * 查询场地管理列表
     * 
     * @param sportFields 场地管理
     * @return 场地管理
     */
    @Override
    public List<SportFields> selectSportFieldsList(SportFields sportFields)
    {
        return sportFieldsMapper.selectSportFieldsList(sportFields);
    }

    /**
     * 新增场地管理
     * 
     * @param sportFields 场地管理
     * @return 结果
     */
    @Override
    public int insertSportFields(SportFields sportFields)
    {
        return sportFieldsMapper.insertSportFields(sportFields);
    }

    /**
     * 修改场地管理
     * 
     * @param sportFields 场地管理
     * @return 结果
     */
    @Override
    public int updateSportFields(SportFields sportFields)
    {
        return sportFieldsMapper.updateSportFields(sportFields);
    }

    /**
     * 批量删除场地管理
     * 
     * @param ids 需要删除的场地管理主键
     * @return 结果
     */
    @Override
    public int deleteSportFieldsByIds(Long[] ids)
    {
        return sportFieldsMapper.deleteSportFieldsByIds(ids);
    }

    /**
     * 删除场地管理信息
     * 
     * @param id 场地管理主键
     * @return 结果
     */
    @Override
    public int deleteSportFieldsById(Long id)
    {
        return sportFieldsMapper.deleteSportFieldsById(id);
    }
}
