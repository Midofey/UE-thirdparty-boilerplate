// Copyright (c) 2025 Midofey Tools. All rights reserved.

using System.IO;
using UnrealBuildTool;

public class UEThirdPartyBoilerplate : ModuleRules
{
    public UEThirdPartyBoilerplate(ReadOnlyTargetRules Target) : base(Target)
    {
        PCHUsage = ModuleRules.PCHUsageMode.UseExplicitOrSharedPCHs;

        PublicDependencyModuleNames.AddRange(
            new string[]
            {
                "Core",
                "CoreUObject",
                "Engine",
                "Projects",
                "Library"
            }
            );
    }
}




