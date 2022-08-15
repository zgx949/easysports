package com.ruoyi.system.controller;

import java.util.List;
import javax.servlet.http.HttpServletResponse;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import com.ruoyi.common.annotation.Log;
import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.common.enums.BusinessType;
import com.ruoyi.system.domain.FitnessTestGrade;
import com.ruoyi.system.service.IFitnessTestGradeService;
import com.ruoyi.common.utils.poi.ExcelUtil;
import com.ruoyi.common.core.page.TableDataInfo;

/**
 * 体测成绩Controller
 * 
 * @author leftHand
 * @date 2022-08-15
 */
@RestController
@RequestMapping("/system/grade")
public class FitnessTestGradeController extends BaseController
{
    @Autowired
    private IFitnessTestGradeService fitnessTestGradeService;

    /**
     * 查询体测成绩列表
     */
    @PreAuthorize("@ss.hasPermi('system:grade:list')")
    @GetMapping("/list")
    public TableDataInfo list(FitnessTestGrade fitnessTestGrade)
    {
        startPage();
        List<FitnessTestGrade> list = fitnessTestGradeService.selectFitnessTestGradeList(fitnessTestGrade);
        return getDataTable(list);
    }

    /**
     * 导出体测成绩列表
     */
    @PreAuthorize("@ss.hasPermi('system:grade:export')")
    @Log(title = "体测成绩", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    public void export(HttpServletResponse response, FitnessTestGrade fitnessTestGrade)
    {
        List<FitnessTestGrade> list = fitnessTestGradeService.selectFitnessTestGradeList(fitnessTestGrade);
        ExcelUtil<FitnessTestGrade> util = new ExcelUtil<FitnessTestGrade>(FitnessTestGrade.class);
        util.exportExcel(response, list, "体测成绩数据");
    }

    /**
     * 获取体测成绩详细信息
     */
    @PreAuthorize("@ss.hasPermi('system:grade:query')")
    @GetMapping(value = "/{id}")
    public AjaxResult getInfo(@PathVariable("id") Long id)
    {
        return AjaxResult.success(fitnessTestGradeService.selectFitnessTestGradeById(id));
    }

    /**
     * 新增体测成绩
     */
    @PreAuthorize("@ss.hasPermi('system:grade:add')")
    @Log(title = "体测成绩", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@RequestBody FitnessTestGrade fitnessTestGrade)
    {
        return toAjax(fitnessTestGradeService.insertFitnessTestGrade(fitnessTestGrade));
    }

    /**
     * 修改体测成绩
     */
    @PreAuthorize("@ss.hasPermi('system:grade:edit')")
    @Log(title = "体测成绩", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@RequestBody FitnessTestGrade fitnessTestGrade)
    {
        return toAjax(fitnessTestGradeService.updateFitnessTestGrade(fitnessTestGrade));
    }

    /**
     * 删除体测成绩
     */
    @PreAuthorize("@ss.hasPermi('system:grade:remove')")
    @Log(title = "体测成绩", businessType = BusinessType.DELETE)
	@DeleteMapping("/{ids}")
    public AjaxResult remove(@PathVariable Long[] ids)
    {
        return toAjax(fitnessTestGradeService.deleteFitnessTestGradeByIds(ids));
    }
}
