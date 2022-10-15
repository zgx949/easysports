package com.ruoyi.system.service;

import java.util.List;

import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.common.core.domain.entity.SysUser;
import com.ruoyi.system.domain.FitnessTestGrade;
import com.ruoyi.system.domain.Vo.FitnessTestGradeVo;
import com.ruoyi.system.domain.Vo.InsertFitnessTestGradeVo;
import org.springframework.web.bind.annotation.RequestBody;

/**
 * 体测成绩Service接口
 *
 * @author leftHand
 * @date 2022-08-23
 */
public interface IFitnessTestGradeService
{
    /**
     * 查询体测成绩
     *
     * @param id 体测成绩主键
     * @return 体测成绩
     */
    public FitnessTestGrade selectFitnessTestGradeById(Long id);

    /**
     * 查询体测成绩列表
     *
     * @param fitnessTestGrade 体测成绩
     * @return 体测成绩集合
     */
    public List<FitnessTestGrade> selectFitnessTestGradeList(FitnessTestGrade fitnessTestGrade);

    /**
     * 新增体测成绩
     *
     * @param fitnessTestGrade 体测成绩
     * @return 结果
     */
    public int insertFitnessTestGrade(FitnessTestGrade fitnessTestGrade);

    /**
     * 修改体测成绩
     *
     * @param fitnessTestGrade 体测成绩
     * @return 结果
     */
    public int updateFitnessTestGrade(FitnessTestGrade fitnessTestGrade);

    /**
     * 批量删除体测成绩
     *
     * @param ids 需要删除的体测成绩主键集合
     * @return 结果
     */
    public int deleteFitnessTestGradeByIds(Long[] ids);

    /**
     * 删除体测成绩信息
     *
     * @param id 体测成绩主键
     * @return 结果
     */
    public int deleteFitnessTestGradeById(Long id);

    /**
    * @Description: 查询自身的成绩情况
    * @Param:
    * @return:
    * @Author: leftHand
    * @Date: 2022-08-25
    */
    public List<FitnessTestGradeVo> queryMyRecord(SysUser user);

    /**
     * 根据用户名列表查询用户信息
     * @param userNameList
     * @return
     */
    public List<SysUser> selectSysUserListByNames(List<String>userNameList);

    /**
     * 批量插入成绩
     * @param fitnessTestGrades
     * @return
     */
    public InsertFitnessTestGradeVo insertGradeList(List<FitnessTestGrade> fitnessTestGrades);

}
