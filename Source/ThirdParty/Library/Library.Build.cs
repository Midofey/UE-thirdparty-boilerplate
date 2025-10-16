// Copyright (c) 2025 Midofey Tools. All rights reserved.

using System.IO;
using UnrealBuildTool;

public class Library : ModuleRules
{
    public Library(ReadOnlyTargetRules Target) : base(Target)
    {
        Type = ModuleType.External;

        PublicSystemIncludePaths.Add(Path.Combine(ModuleDirectory, "Include"));
        PublicDefinitions.Add("WITH_Library=1");
    }
}




