package com.ruoyi.system.controller;

import java.util.Collections;
import java.util.List;
import java.util.Map;
import java.util.concurrent.TimeUnit;
import java.util.stream.Collectors;
import javax.servlet.http.HttpServletResponse;

import com.ruoyi.common.annotation.Log;
import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.common.core.domain.entity.SysDept;
import com.ruoyi.common.core.domain.entity.SysUser;
import com.ruoyi.common.core.page.TableDataInfo;
import com.ruoyi.common.core.redis.RedisCache;
import com.ruoyi.common.enums.BusinessType;
import com.ruoyi.common.exception.ServiceException;
import com.ruoyi.common.utils.DateUtils;
import com.ruoyi.common.utils.SecurityUtils;
import com.ruoyi.common.utils.poi.ExcelUtil;
import com.ruoyi.system.domain.SportGames;
import com.ruoyi.system.domain.SportItem;
import com.ruoyi.system.domain.SportRegistrations;
import com.ruoyi.system.domain.Vo.GameSequenceBookVO;
import com.ruoyi.system.domain.Vo.UserSportGradeVo;
import com.ruoyi.system.domain.dto.UpdateGamesScoreDto;
import com.ruoyi.system.service.ISportGamesService;
import com.ruoyi.system.service.ISportItemService;
import com.ruoyi.system.service.ISportRegistrationsService;
import com.ruoyi.system.service.ISysUserService;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.apache.commons.lang3.ObjectUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletResponse;
import java.util.List;
import java.util.Map;
import java.util.concurrent.TimeUnit;

/**
 * 报名管理Controller
 *
 * @author leftHand
 * @date 2022-07-06
 */
@RestController
@Api
@RequestMapping("/system/registrations")
public class SportRegistrationsController extends BaseController {
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
    public AjaxResult register(@RequestBody Map<String, String> sportRegistrations) {
        return toAjax(sportRegistrationsService.userInsertSportRegistrations(sportRegistrations));
    }

    /**
     * 查询报名管理列表
     */
    @PreAuthorize("@ss.hasPermi('system:registrations:list')")
    @GetMapping("/list")
    public TableDataInfo list(SportRegistrations sportRegistrations) {
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
    public void export(HttpServletResponse response, SportRegistrations sportRegistrations) {
        List<SportRegistrations> list = sportRegistrationsService.selectSportRegistrationsList(sportRegistrations);
        ExcelUtil<SportRegistrations> util = new ExcelUtil<SportRegistrations>(SportRegistrations.class);
        util.exportExcel(response, list, "报名管理数据");
    }

    /**
     * 获取报名管理详细信息
     */
    @PreAuthorize("@ss.hasPermi('system:registrations:query')")
    @GetMapping(value = "/{id}")
    public AjaxResult getInfo(@PathVariable("id") Long id) {
        return AjaxResult.success(sportRegistrationsService.selectSportRegistrationsById(id));
    }

    /**
     * 新增报名管理
     */
    @PreAuthorize("@ss.hasPermi('system:registrations:add')")
    @Log(title = "报名管理", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@RequestBody SportRegistrations sportRegistrations) {
        return toAjax(sportRegistrationsService.insertSportRegistrations(sportRegistrations));
    }

    /**
     * 修改报名管理
     */
    @PreAuthorize("@ss.hasPermi('system:registrations:edit')")
    @Log(title = "报名管理", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@RequestBody SportRegistrations sportRegistrations) {
        return toAjax(sportRegistrationsService.updateSportRegistrations(sportRegistrations));
    }

    /**
     * 删除报名管理
     */
    @PreAuthorize("@ss.hasPermi('system:registrations:remove')")
    @Log(title = "报名管理", businessType = BusinessType.DELETE)
    @DeleteMapping("/{ids}")
    public AjaxResult remove(@PathVariable Long[] ids) {
        return toAjax(sportRegistrationsService.deleteSportRegistrationsByIds(ids));
    }

    /**
     * 根据用户id查询报名比赛
     */
    @PreAuthorize("@ss.hasPermi('system:registrations:list')")
    @ApiOperation("根据用户id查询报名比赛")
    @GetMapping("/user/list")
    public TableDataInfo userRegisterationslist(SportRegistrations sportRegistrations) {
        sportRegistrations.setUserId(SecurityUtils.getUserId());
        //查询当前用户报名的比赛集合并且分页
        startPage();
        List<SportRegistrations> sportRegistrationsList= sportRegistrationsService.selectSportRegistrationsList(sportRegistrations);

        //遍历集合获取用户每项比赛成绩
        List<UserSportGradeVo> userSportGradeVoList=sportRegistrationsList.stream().map((item)->{
            UserSportGradeVo userSportGradeVo= sportRegistrationsService.selectUserSportGrade(item.getGameId());
            return userSportGradeVo;
        }).collect(Collectors.toList());

        return getDataTable(userSportGradeVoList);
    }

    /**
     * 根据比赛id和用户id查询成绩
     */
    @PreAuthorize("@ss.hasPermi('system:registrations:query')")
    @GetMapping("/user/{gameId}")
    public AjaxResult userScore(@PathVariable("gameId") Long gameId)
    {
        UserSportGradeVo userSportGradeVo = sportRegistrationsService.selectUserSportGrade(gameId);
        return AjaxResult.success(userSportGradeVo);
    }

    /**
     * 用户报名比赛
     */
//    @PreAuthorize("@ss.hasPermi('system:registrations:add')")
    @PostMapping("/user/{gameId}")
    public AjaxResult insertUserRegistrations(SportRegistrations sportRegistrations) {
        Long userId = SecurityUtils.getUserId();
        SysUser sysUser = sysUserService.selectUserById(userId);
        Long deptId = sysUser.getDeptId();
        Long gameId = sportRegistrations.getGameId();

        String userSex = sysUser.getSex();
        SportGames sportGames = sportGamesService.selectSportGamesById(sportRegistrations.getGameId());
        Long numOfGames = sportRegistrationsService.numOfRegistrationsGames(sportRegistrations.getGameId());
        //检验比赛报名人数是否已满
        if(numOfGames>=sportGames.getMaxPerson()){
            return AjaxResult.error("参赛人数已满");
        }
        //检验用户报名性别是否合法
        Integer sportGender = sportGames.getGender();
        if(Integer.parseInt(userSex)!=sportGender&&sportGender!=-1){
            return AjaxResult.error("用户性别错误");
        }

        //判断报名时是否在报名时间段内
        if(sportGames.getStatus()!=0){
            return AjaxResult.error("未在报名时间段内");
        }

        //检验用户是否已经报名该比赛
        sportRegistrations.setUserId(userId);
        List<SportRegistrations> sportRegistrationsList = sportRegistrationsService.selectSportRegistrationsList(sportRegistrations);
        if (sportRegistrationsList.size() != 0) {
            return AjaxResult.error("用户已报名该比赛");
        }

        SportItem sportItem = sportItemService.selectSportItemById(sportGames.getItemId());
        Long type = sportItem.getType();//获取当前比赛的类型，是径赛还是田赛还是团体赛
        Long itemId= sportItem.getId();
        //判断是否是田径赛
        if(type==1L||type==2L){
            //判断是不是接力赛
            if(itemId==11L||itemId==12L){
                if(!sportRegistrationsService.RelayGameRegistrationIsLegal(deptId,gameId,8L)){
                    return AjaxResult.error("学院接力赛项目报名人数已满");
                }
            }else {
                //判断该院该项目(不包括接力)是否满额(名额限为3)
                if(!sportRegistrationsService.numOfCollegeRegistrationIsLegal(deptId,gameId,3L)){
                    return AjaxResult.error("所在学院该项目名额已满");
                }
                //判断当前用户报名的田径类赛事是否满额(名额限为2)
                if(!sportRegistrationsService.TrackFieldGameRegistrationIsLegal(userId,2L)){
                    return AjaxResult.error("用户已报名2项田径类赛事");
                }
            }
        }
        // TODO: 报名限制：学生组田径项目每队限报3人，每人限报两项，4*100和4*400每队可报两组即分别8人

        sportRegistrations.setStatus("0");
        sportRegistrations.setUserId(SecurityUtils.getUserId());
        sportRegistrations.setUpdateTime(DateUtils.getNowDate());
        sportRegistrations.setCreateTime(DateUtils.getNowDate());

        return toAjax(sportRegistrationsService.insertUserRegistrations(sportRegistrations));
    }

    /**
     * 用户取消报名
     */
//    @PreAuthorize("@ss.hasPermi('system:registrations:remove')")
    @DeleteMapping("/user/{gameId}")
    public AjaxResult deleteUserRegistrations(@PathVariable("gameId") Long gameId)
    {
        SportGames sportGames = sportGamesService.selectSportGamesById(gameId);

        //判断用户是否已经报名
        SportRegistrations sportRegistrations=new SportRegistrations();
        sportRegistrations.setGameId(gameId);
        sportRegistrations.setUserId(SecurityUtils.getUserId());
        List<SportRegistrations> sportRegistrationsList= sportRegistrationsService.selectSportRegistrationsList(sportRegistrations);
        if(sportRegistrationsList.size()==0){
            return AjaxResult.error("用户未报名该比赛");
        }

        //判断报名审核是否通过
        String status = sportRegistrationsList.get(0).getStatus();
        if(status.equals("1")){
            return AjaxResult.error("审核通过，不可取消报名");
        }


        //判断取消报名时是否在报名时间段内
        if(sportGames.getStatus()!=0){
            return AjaxResult.error("未在报名时间段内");
        }

        return toAjax(sportRegistrationsService.deleteUserRegistrations(SecurityUtils.getUserId(),gameId));
    }


    @PreAuthorize("@ss.hasPermi('system:registrations:edit')")
    @ApiOperation("管理员录入成绩")
    @PutMapping("update/score")
    public AjaxResult updateGamesScore(@RequestBody UpdateGamesScoreDto updateGamesScoreDto) {
        if (!SecurityUtils.getLoginUser().getUser().isAdmin()) {
            throw new ServiceException("无此权限");
        }
        if (sportRegistrationsService.handleUpdateScore(updateGamesScoreDto)) {
            return AjaxResult.success();
        }
        return AjaxResult.error("录入成绩失败");
    }


    /**
     * 获取生成秩序册所需必要信息
     */
    @PreAuthorize("@ss.hasPermi('system:registrations:query')")
    @GetMapping()
    @ApiOperation("获取生成秩序册所需必要信息")
    public AjaxResult getGameSequenceBookVO() {
        List<GameSequenceBookVO> gameSequenceBookVOS = sportRegistrationsService.exportGameSequenceBookVo();


        return AjaxResult.success(gameSequenceBookVOS);
    }
}
