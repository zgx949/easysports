package com.ruoyi.system.controller;

import java.util.List;
import java.util.Map;
import java.util.concurrent.TimeUnit;
import java.util.stream.Collectors;
import javax.servlet.http.HttpServletResponse;

import com.ruoyi.common.core.domain.entity.SysUser;
import com.ruoyi.common.core.domain.model.LoginUser;
import com.ruoyi.common.core.redis.RedisCache;
import com.ruoyi.common.utils.DateUtils;
import com.ruoyi.common.utils.SecurityUtils;
import com.ruoyi.system.domain.SportFields;
import com.ruoyi.system.domain.SportGames;
import com.ruoyi.system.domain.SportItem;
import com.ruoyi.system.domain.Vo.UserSportGradeVo;
import com.ruoyi.system.service.*;
import org.apache.commons.lang3.ObjectUtils;
import org.springframework.cache.annotation.Cacheable;
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
import com.ruoyi.system.domain.SportRegistrations;
import com.ruoyi.common.utils.poi.ExcelUtil;
import com.ruoyi.common.core.page.TableDataInfo;

/**
 * 报名管理Controller
 *
 * @author leftHand
 * @date 2022-07-06
 */
@RestController
@RequestMapping("/system/registrations")
public class SportRegistrationsController extends BaseController
{
    @Autowired
    private ISportRegistrationsService sportRegistrationsService;

    @Autowired
    private ISportItemService sportItemService;
    
    @Autowired
    private ISportGamesService sportGamesService;

    @Autowired
    private ISysUserService sysUserService;

    @Autowired
    private RedisCache redisCache;

    /**
     * 新增报名管理
     */
    @Log(title = "用户报名", businessType = BusinessType.INSERT)
    @PostMapping("/register")
    public AjaxResult register(@RequestBody Map<String, String> sportRegistrations)
    {
        return toAjax(sportRegistrationsService.userInsertSportRegistrations(sportRegistrations));
    }

    /**
     * 查询报名管理列表
     */
    @PreAuthorize("@ss.hasPermi('system:registrations:list')")
    @GetMapping("/list")
    public TableDataInfo list(SportRegistrations sportRegistrations)
    {
        // 如果传递的积分参数为0（前端默认传0，不是null，所以会导致查询数据丢失）
        Long points = sportRegistrations.getPoints();
        if (points == null || points.equals(0L)) {
            sportRegistrations.setPoints(null);
        }
        startPage();
        List<SportRegistrations> list = sportRegistrationsService.selectSportRegistrationsList(sportRegistrations);
        return getDataTable(list);
    }

    /**
     * 导出报名管理列表
     */
    @PreAuthorize("@ss.hasPermi('system:registrations:export')")
    @Log(title = "报名管理", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    public void export(HttpServletResponse response, SportRegistrations sportRegistrations)
    {
        List<SportRegistrations> list = sportRegistrationsService.selectSportRegistrationsList(sportRegistrations);
        ExcelUtil<SportRegistrations> util = new ExcelUtil<SportRegistrations>(SportRegistrations.class);
        util.exportExcel(response, list, "报名管理数据");
    }

    /**
     * 获取报名管理详细信息
     */
    @PreAuthorize("@ss.hasPermi('system:registrations:query')")
    @GetMapping(value = "/{id}")
    public AjaxResult getInfo(@PathVariable("id") Long id)
    {
        return AjaxResult.success(sportRegistrationsService.selectSportRegistrationsById(id));
    }

    /**
     * 新增报名管理
     */
    @PreAuthorize("@ss.hasPermi('system:registrations:add')")
    @Log(title = "报名管理", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@RequestBody SportRegistrations sportRegistrations)
    {
        return toAjax(sportRegistrationsService.insertSportRegistrations(sportRegistrations));
    }

    /**
     * 修改报名管理
     */
    @PreAuthorize("@ss.hasPermi('system:registrations:edit')")
    @Log(title = "报名管理", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@RequestBody SportRegistrations sportRegistrations)
    {
        return toAjax(sportRegistrationsService.updateSportRegistrations(sportRegistrations));
    }

    /**
     * 删除报名管理
     */
    @PreAuthorize("@ss.hasPermi('system:registrations:remove')")
    @Log(title = "报名管理", businessType = BusinessType.DELETE)
    @DeleteMapping("/{ids}")
    public AjaxResult remove(@PathVariable Long[] ids)
    {
        return toAjax(sportRegistrationsService.deleteSportRegistrationsByIds(ids));
    }

    /**
     * 根据用户id查询报名比赛
     */
    @PreAuthorize("@ss.hasPermi('system:registrations:list')")
    @GetMapping("/user/list")
    public TableDataInfo userRegisterationslist(SportRegistrations sportRegistrations)
    {
        sportRegistrations.setUserId(SecurityUtils.getUserId());
        startPage();
        List<SportRegistrations> sportRegistrationsList= sportRegistrationsService.userRegisterationslist(sportRegistrations);
        return getDataTable(sportRegistrationsList);
    }

    /**
     * 根据比赛id和用户id查询成绩
     */
    @PreAuthorize("@ss.hasPermi('system:registrations:query')")
    @GetMapping("/user/{gameId}")
    public AjaxResult userScore(@PathVariable("gameId") Long gameId)
    {
        String redisKey = "userSportGrade:" + SecurityUtils.getUserId()+":"+gameId;
        UserSportGradeVo cacheObject = (UserSportGradeVo)redisCache.getCacheObject(redisKey);
        if(!ObjectUtils.isEmpty(cacheObject)){
            return AjaxResult.success(cacheObject);
        }
        SportRegistrations sportRegistrations=new SportRegistrations();
        sportRegistrations.setGameId(gameId);
        //查询参加该比赛的所有报名集合
        List<SportRegistrations> sportRegistrationsList = sportRegistrationsService.selectSportRegistrationsList(sportRegistrations);

        SportRegistrations userSportRegistrations=new SportRegistrations();//用于从集合中获得用户的报名信息
        //遍历集合从中获取当前用户成绩
        for(SportRegistrations temp:sportRegistrationsList){
            if(SecurityUtils.getUserId()==temp.getUserId()){
                userSportRegistrations=temp;
            }
        }
        if(userSportRegistrations.getScore()==null){
            return AjaxResult.error("未查询到用户成绩");
        }
        UserSportGradeVo userSportGradeVo=new UserSportGradeVo();

        //根据比赛id查出比赛的item_id
        SportGames sportGames = sportGamesService.selectSportGamesById(gameId);
        Long itemId = sportGames.getItemId();
        //根据item_id查出降序还是升序
        SportItem sportItem = sportItemService.selectSportItemById(itemId);
        Long isDesc = sportItem.getIsDesc();

        sportGames.setItem(sportItem);
        userSportRegistrations.setGame(sportGames);
        userSportGradeVo.setSportRegistrations(userSportRegistrations);

        //根据升序降序对用户进行排名
        Long userOrder=1L;
        for(SportRegistrations temp:sportRegistrationsList){
           if(temp.getScore()!=null){
               if(isDesc==1){//降序
                   if(temp.getScore()!=null&&userSportRegistrations.getScore()<temp.getScore()){
                       userOrder++;
                   }
               }else {//升序
                   if(temp.getScore()!=null&&userSportRegistrations.getScore()>temp.getScore()){
                       userOrder++;
                   }
               }
           }
        }
        userSportGradeVo.setUserOrder(userOrder);
        //将用户当前成绩缓存，缓存时长设置为1h
        redisCache.setCacheObject(redisKey,userSportGradeVo,1, TimeUnit.HOURS);

        return AjaxResult.success(userSportGradeVo);
    }

    /**
     * 用户报名比赛
     */
    @PreAuthorize("@ss.hasPermi('system:registrations:add')")
    @PostMapping("/user/{gameId}")
    public AjaxResult insertUserRegistrations(SportRegistrations sportRegistrations)
    {
        Long userId = SecurityUtils.getUserId();
        //检验用户是否已经报名该比赛
        sportRegistrations.setUserId(userId);
        List<SportRegistrations> sportRegistrationsList= sportRegistrationsService.selectSportRegistrationsList(sportRegistrations);
        if(sportRegistrationsList.size()!=0){
            return AjaxResult.error("用户已报名该比赛");
        }

        //检验用户报名性别是否合法
        SysUser sysUser = sysUserService.selectUserById(userId);
        String userSex = sysUser.getSex();
        SportGames sportGames = sportGamesService.selectSportGamesById(sportRegistrations.getGameId());
        if(Integer.parseInt(userSex)!=sportGames.getGender()){
            return AjaxResult.error("用户性别错误");
        }

        sportRegistrations.setUserId(SecurityUtils.getUserId());
        sportRegistrations.setUpdateTime(DateUtils.getNowDate());
        sportRegistrations.setCreateTime(DateUtils.getNowDate());

        return toAjax(sportRegistrationsService.insertUserRegistrations(sportRegistrations));
    }

    /**
     * 用户取消报名
     */
    @PreAuthorize("@ss.hasPermi('system:registrations:remove')")
    @DeleteMapping("/user/{gameId}")
    public AjaxResult deleteUserRegistrations(@PathVariable("gameId") Long gameId)
    {
        return toAjax(sportRegistrationsService.deleteUserRegistrations(SecurityUtils.getUserId(),gameId));
    }

}
