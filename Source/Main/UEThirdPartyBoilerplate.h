// Copyright (c) 2025 Midofey Tools. All rights reserved.

#pragma once

#include "Modules/ModuleManager.h"

class FUEThirdPartyBoilerplateModule : public IModuleInterface
{
public:

	/** IModuleInterface implementation */
	virtual void StartupModule() override;
	virtual void ShutdownModule() override;

};


