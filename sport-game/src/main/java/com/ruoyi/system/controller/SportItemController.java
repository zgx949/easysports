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
import com.ruoyi.system.domain.SportItem;
import com.ruoyi.system.service.ISportItemService;
import com.ruoyi.common.utils.poi.ExcelUtil;
import com.ruoyi.common.core.page.TableDataInfo;

/**
 * 项目管理Controller
 * 
 * @author ruoyi
 * @date 2022-06-30
 */
@RestController
@RequestMapping("/system/item")
public class SportItemController extends BaseController
{
    @Autowired
    private ISportItemService sportItemService;

    /**
     * 查询项目管理列表
     */
    @PreAuthorize("@ss.hasPermi('system:item:list')")
    @GetMapping("/list")
    public TableDataInfo list(SportItem sportItem)
    {
        startPage();
        List<SportItem> list = sportItemService.selectSportItemList(sportItem);
        return getDataTable(list);
    }

    /**
     * 导出项目管理列表
     */
    @PreAuthorize("@ss.hasPermi('system:item:export')")
    @Log(title = "项目管理", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    public void export(HttpServletResponse response, SportItem sportItem)
    {
        List<SportItem> list = sportItemService.selectSportItemList(sportItem);
        ExcelUtil<SportItem> util = new ExcelUtil<SportItem>(SportItem.class);
        util.exportExcel(response, list, "项目管理数据");
    }

    /**
     * 获取项目管理详细信息
     */
    @PreAuthorize("@ss.hasPermi('system:item:query')")
    @GetMapping(value = "/{id}")
    public AjaxResult getInfo(@PathVariable("id") Long id)
    {
        return AjaxResult.success(sportItemService.selectSportItemById(id));
    }

    /**
     * 新增项目管理
     */
    @PreAuthorize("@ss.hasPermi('system:item:add')")
    @Log(title = "项目管理", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@RequestBody SportItem sportItem)
    {
        return toAjax(sportItemService.insertSportItem(sportItem));
    }

    /**
     * 修改项目管理
     */
    @PreAuthorize("@ss.hasPermi('system:item:edit')")
    @Log(title = "项目管理", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@RequestBody SportItem sportItem)
    {
        return toAjax(sportItemService.updateSportItem(sportItem));
    }

    /**
     * 删除项目管理
     */
    @PreAuthorize("@ss.hasPermi('system:item:remove')")
    @Log(title = "项目管理", businessType = BusinessType.DELETE)
	@DeleteMapping("/{ids}")
    public AjaxResult remove(@PathVariable Long[] ids)
    {
        return toAjax(sportItemService.deleteSportItemByIds(ids));
    }
}
