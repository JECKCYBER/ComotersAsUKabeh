local M = {}

local GameplayStatics =
    import("GameplayStatics")

local GameplayData =
    require("GameLua.GameCore.Data.GameplayData")

--------------------------------------------------
-- INIT
--------------------------------------------------

function M.Init()

    print("TES MODULE INIT")
end

--------------------------------------------------
-- GLOBAL FUNCTIONS
--------------------------------------------------

_G.SetMaterialRender = function(
    self,
    DisableDepth,
    BlendMode
)

    local mesh =
        self.Mesh

    if not mesh then
        return
    end

    local matInterface =
        mesh:GetMaterial(0)

    if not matInterface then
        return
    end

    local baseMat =
        matInterface:GetBaseMaterial()

    if not baseMat then
        return
    end

    baseMat.bDisableDepthTest =
        DisableDepth

    baseMat.BlendMode =
        BlendMode
end

--------------------------------------------------

_G.ApplyNoRecoil = function(self)

    local weaponManager =
        self.WeaponManagerComponent

    if not weaponManager then
        return
    end

    local currentWeapon =
        weaponManager.CurrentWeaponReplicated

    if not currentWeapon then
        return
    end

    local shootComp =
        currentWeapon.ShootWeaponEntityComp

    if not shootComp then
        return
    end

    --------------------------------------------------
    -- BASIC
    --------------------------------------------------

    shootComp.RecoilKick = 0
    shootComp.RecoilKickADS = 0
    shootComp.AnimationKick = 0

    shootComp.AccessoriesHRecoilFactor = 0.3
    shootComp.AccessoriesRecoveryFactor = 0.3
    shootComp.AccessoriesVRecoilFactor = 0.3

    shootComp.BulletFireSpeed = 900000

    --------------------------------------------------
    -- RECOIL INFO
    --------------------------------------------------

    local r =
        shootComp.RecoilInfo

    if r then

        r.VerticalRecoilMin = 0
        r.VerticalRecoilMax = 0
        r.RecoilSpeedVertical = 0
        r.RecoilSpeedHorizontal = 0
        r.VerticalRecoveryMax = 0

        r.RecoilModifierStand = 0
        r.RecoilModifierCrouch = 0
        r.RecoilModifierProne = 0
    end

    --------------------------------------------------
    -- AIM CONFIG
    --------------------------------------------------

    local aa =
        shootComp.AutoAimingConfig

    if aa then

        aa.OuterRange.Speed = 10
        aa.InnerRange.Speed = 10

        aa.OuterRange.SpeedRate = 10
        aa.InnerRange.SpeedRate = 10

        aa.OuterRange.RangeRate = 2
        aa.InnerRange.RangeRate = 2

        aa.OuterRange.RangeRateSight = 2
        aa.InnerRange.RangeRateSight = 2

        aa.OuterRange.SpeedRateSight = 10
        aa.InnerRange.SpeedRateSight = 10

        aa.OuterRange.CrouchRate = 2
        aa.InnerRange.CrouchRate = 2

        aa.OuterRange.ProneRate = 2
        aa.InnerRange.ProneRate = 2

        aa.OuterRange.DyingRate = 0
        aa.InnerRange.DyingRate = 0

        shootComp.WeaponAimInTime = 7
        shootComp.GameDeviationFactor = 0
        shootComp.GameDeviationAccuracy = 0
    end
end

--------------------------------------------------

_G.SetFOV110 = function(self)

    local camera =
        self.ThirdPersonCameraComponent

    if not camera then
        return
    end

    camera:SetFieldOfView(110)
end

--------------------------------------------------
-- TICK
--------------------------------------------------

function M.OnTick(self, DeltaTime)

    pcall(
        _G.ApplyNoRecoil,
        self
    )

    pcall(
        _G.SetFOV110,
        self
    )

    pcall(
        _G.SetMaterialRender,
        self,
        true,
        2
    )
end

return M