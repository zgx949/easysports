package com.ruoyi.system.service.impl;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.ruoyi.system.mapper.SportItemMapper;
import com.ruoyi.system.domain.SportItem;
import com.ruoyi.system.service.ISportItemService;

/**
 * 项目管理Service业务层处理
 * 
 * @author ruoyi
 * @date 2022-06-30
 */
@Service
public class SportItemServiceImpl implements ISportItemService 
{
    @Autowired
    private SportItemMapper sportItemMapper;

    /**
     * 查询项目管理
     * 
     * @param id 项目管理主键
     * @return 项目管理
     */
    @Override
    public SportItem selectSportItemById(Long id)
    {
        return sportItemMapper.selectSportItemById(id);
    }

    /**
     * 查询项目管理列表
     * 
     * @param sportItem 项目管理
     * @return 项目管理
     */
    @Override
    public List<SportItem> selectSportItemList(SportItem sportItem)
    {
        return sportItemMapper.selectSportItemList(sportItem);
    }

    /**
     * 新增项目管理
     * 
     * @param sportItem 项目管理
     * @return 结果
     */
    @Override
    public int insertSportItem(SportItem sportItem)
    {
        return sportItemMapper.insertSportItem(sportItem);
    }

    /**
     * 修改项目管理
     * 
     * @param sportItem 项目管理
     * @return 结果
     */
    @Override
    public int updateSportItem(SportItem sportItem)
    {
        return sportItemMapper.updateSportItem(sportItem);
    }

    /**
     * 批量删除项目管理
     * 
     * @param ids 需要删除的项目管理主键
     * @return 结果
     */
    @Override
    public int deleteSportItemByIds(Long[] ids)
    {
        return sportItemMapper.deleteSportItemByIds(ids);
    }

    /**
     * 删除项目管理信息
     * 
     * @param id 项目管理主键
     * @return 结果
     */
    @Override
    public int deleteSportItemById(Long id)
    {
        return sportItemMapper.deleteSportItemById(id);
    }
}
