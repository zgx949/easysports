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
import com.ruoyi.system.domain.SportFields;
import com.ruoyi.system.service.ISportFieldsService;
import com.ruoyi.common.utils.poi.ExcelUtil;

/**
 * 场地管理Controller
 * 
 * @author ruoyi
 * @date 2022-06-30
 */
@RestController
@RequestMapping("/system/fields")
public class SportFieldsController extends BaseController
{
    @Autowired
    private ISportFieldsService sportFieldsService;

    /**
     * 查询场地管理列表
     */
    @PreAuthorize("@ss.hasPermi('system:fields:list')")
    @GetMapping("/list")
    public AjaxResult list(SportFields sportFields)
    {
        List<SportFields> list = sportFieldsService.selectSportFieldsList(sportFields);
        return AjaxResult.success(list);
    }

    /**
     * 导出场地管理列表
     */
    @PreAuthorize("@ss.hasPermi('system:fields:export')")
    @Log(title = "场地管理", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    public void export(HttpServletResponse response, SportFields sportFields)
    {
        List<SportFields> list = sportFieldsService.selectSportFieldsList(sportFields);
        ExcelUtil<SportFields> util = new ExcelUtil<SportFields>(SportFields.class);
        util.exportExcel(response, list, "场地管理数据");
    }

    /**
     * 获取场地管理详细信息
     */
    @PreAuthorize("@ss.hasPermi('system:fields:query')")
    @GetMapping(value = "/{id}")
    public AjaxResult getInfo(@PathVariable("id") Long id)
    {
        return AjaxResult.success(sportFieldsService.selectSportFieldsById(id));
    }

    /**
     * 新增场地管理
     */
    @PreAuthorize("@ss.hasPermi('system:fields:add')")
    @Log(title = "场地管理", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@RequestBody SportFields sportFields)
    {
        return toAjax(sportFieldsService.insertSportFields(sportFields));
    }

    /**
     * 修改场地管理
     */
    @PreAuthorize("@ss.hasPermi('system:fields:edit')")
    @Log(title = "场地管理", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@RequestBody SportFields sportFields)
    {
        return toAjax(sportFieldsService.updateSportFields(sportFields));
    }

    /**
     * 删除场地管理
     */
    @PreAuthorize("@ss.hasPermi('system:fields:remove')")
    @Log(title = "场地管理", businessType = BusinessType.DELETE)
	@DeleteMapping("/{ids}")
    public AjaxResult remove(@PathVariable Long[] ids)
    {
        return toAjax(sportFieldsService.deleteSportFieldsByIds(ids));
    }
}
