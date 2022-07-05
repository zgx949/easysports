package com.ruoyi.system.service;

import java.util.List;

import com.ruoyi.common.core.domain.Dict;
import com.ruoyi.system.domain.SportItem;

/**
 * 项目管理Service接口
 * 
 * @author ruoyi
 * @date 2022-06-30
 */
public interface ISportItemService 
{
    /**
     * 查询比赛预决赛字典信息
     *
     * @return 比赛管理
     */
    public List<Dict> selectSportItemsDict();

    /**
     * 查询项目管理
     * 
     * @param id 项目管理主键
     * @return 项目管理
     */
    public SportItem selectSportItemById(Long id);

    /**
     * 查询项目管理列表
     * 
     * @param sportItem 项目管理
     * @return 项目管理集合
     */
    public List<SportItem> selectSportItemList(SportItem sportItem);

    /**
     * 新增项目管理
     * 
     * @param sportItem 项目管理
     * @return 结果
     */
    public int insertSportItem(SportItem sportItem);

    /**
     * 修改项目管理
     * 
     * @param sportItem 项目管理
     * @return 结果
     */
    public int updateSportItem(SportItem sportItem);

    /**
     * 批量删除项目管理
     * 
     * @param ids 需要删除的项目管理主键集合
     * @return 结果
     */
    public int deleteSportItemByIds(Long[] ids);

    /**
     * 删除项目管理信息
     * 
     * @param id 项目管理主键
     * @return 结果
     */
    public int deleteSportItemById(Long id);
}
