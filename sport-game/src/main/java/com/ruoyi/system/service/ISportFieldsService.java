package com.ruoyi.system.service;

import java.util.List;

import com.ruoyi.common.core.domain.Dict;
import com.ruoyi.system.domain.SportFields;

/**
 * 场地管理Service接口
 * 
 * @author ruoyi
 * @date 2022-06-30
 */
public interface ISportFieldsService 
{
    /**
     * 查询场地字典信息
     *
     * @return 比赛管理
     */
    public List<Dict> selectSportFieldsDict();

    /**
     * 查询场地管理
     * 
     * @param id 场地管理主键
     * @return 场地管理
     */
    public SportFields selectSportFieldsById(Long id);

    /**
     * 查询场地管理列表
     * 
     * @param sportFields 场地管理
     * @return 场地管理集合
     */
    public List<SportFields> selectSportFieldsList(SportFields sportFields);

    /**
     * 新增场地管理
     * 
     * @param sportFields 场地管理
     * @return 结果
     */
    public int insertSportFields(SportFields sportFields);

    /**
     * 修改场地管理
     * 
     * @param sportFields 场地管理
     * @return 结果
     */
    public int updateSportFields(SportFields sportFields);

    /**
     * 批量删除场地管理
     * 
     * @param ids 需要删除的场地管理主键集合
     * @return 结果
     */
    public int deleteSportFieldsByIds(Long[] ids);

    /**
     * 删除场地管理信息
     * 
     * @param id 场地管理主键
     * @return 结果
     */
    public int deleteSportFieldsById(Long id);
}
