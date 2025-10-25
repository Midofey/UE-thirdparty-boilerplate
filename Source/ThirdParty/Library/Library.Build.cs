// Copyright (c) 2025 Midofey Tools. All rights reserved.

using System.IO;
using System.Linq;
using UnrealBuildTool;

public class Library : ModuleRules
{
    public Library(ReadOnlyTargetRules Target) : base(Target)
    {
        Type = ModuleType.External;

        PublicSystemIncludePaths.Add(Path.Combine(ModuleDirectory, "Include"));
        PublicDefinitions.Add("WITH_Library=1");

        string[] SupportedPlatforms = ["Win64", "Win32", "Linux", "Mac"];
        string StaticLibraryExtension;
        string DynamicLibraryExtension;

        if (Target.Platform == UnrealTargetPlatform.Win64)
        {
            StaticLibraryExtension = ".lib";
            DynamicLibraryExtension = ".dll";
        }
        else if (Target.Platform == UnrealTargetPlatform.Linux)
        {
            StaticLibraryExtension = ".a";
            DynamicLibraryExtension = ".so";
        }
        else if (Target.Platform == UnrealTargetPlatform.Mac)
        {
            StaticLibraryExtension = ".a";
            DynamicLibraryExtension = ".dylib";
        }
        else
        {
            StaticLibraryExtension = "";
            DynamicLibraryExtension = "";
        }

        string ReleasePath = Path.Combine(ModuleDirectory, "Release", Target.Platform.ToString());

        if (Directory.Exists(ReleasePath))
        {
            string[] Files = Directory.GetFiles(ReleasePath, "*.*", SearchOption.AllDirectories);
            if (Files.Length == 0)
            {
                Log.TraceWarning($"No dependency files were found in the Release directory for platform {Target.Platform.ToString()} at path: {ReleasePath}");
            }

            foreach (string File in Files)
            {
                if (Path.GetExtension(File) == StaticLibraryExtension)
                {
                    PublicAdditionalLibraries.Add(File);
                }
                else if (Path.GetExtension(File) == DynamicLibraryExtension)
                {
                    RuntimeDependencies.Add(File);
                }

                Log.TraceInformation($"Added a new dependency file: {File}");
            }
        }
        else
        {
            Log.TraceWarning($"The Release directory does not exist for platform {Target.Platform.ToString()} at path: {ReleasePath}");
        }

        if (!SupportedPlatforms.Contains(Target.Platform.ToString()))
        {
            PublicDefinitions.Add("WITH_Library=0");
            Log.TraceWarning($"Library is not supported on platform {Target.Platform.ToString()}. Disabling Library integration.");
        }
    }
}




