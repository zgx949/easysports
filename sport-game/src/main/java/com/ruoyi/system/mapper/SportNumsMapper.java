package com.ruoyi.system.mapper;

import java.util.List;
import com.ruoyi.system.domain.SportNums;

/**
 * 号码段管理Mapper接口
 *
 * @author ruoyi
 * @date 2022-07-01
 */
public interface SportNumsMapper {
    /**
     * 查询号码段管理
     *
     * @param id 号码段管理主键
     * @return 号码段管理
     */
    public SportNums selectSportNumsById(Long id);

    /**
     * 查询号码段管理列表
     *
     * @param sportNums 号码段管理
     * @return 号码段管理集合
     */
    public List<SportNums> selectSportNumsList(SportNums sportNums);

    /**
     * 新增号码段管理
     *
     * @param sportNums 号码段管理
     * @return 结果
     */
    public int insertSportNums(SportNums sportNums);

    /**
     * 修改号码段管理
     *
     * @param sportNums 号码段管理
     * @return 结果
     */
    public int updateSportNums(SportNums sportNums);

    /**
     * 删除号码段管理
     *
     * @param id 号码段管理主键
     * @return 结果
     */
    public int deleteSportNumsById(Long id);

    /**
     * 批量删除号码段管理
     *
     * @param ids 需要删除的数据主键集合
     * @return 结果
     */
    public int deleteSportNumsByIds(Long[] ids);
}
