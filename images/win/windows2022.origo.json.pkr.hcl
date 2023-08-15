# This file was autogenerated by the 'packer hcl2_upgrade' command. We
# recommend double checking that everything is correct before going forward. We
# also recommend treating this file as disposable. The HCL2 blocks in this
# file can be moved to other files. For example, the variable blocks could be
# moved to their own 'variables.pkr.hcl' file, etc. Those files need to be
# suffixed with '.pkr.hcl' to be visible to Packer. To use multiple files at
# once they also need to be in the same folder. 'packer inspect folder/'
# will describe to you what is in that folder.

# Avoid mixing go templating calls ( for example ```{{ upper(`string`) }}``` )
# and HCL2 calls (for example '${ var.string_value_example }' ). They won't be
# executed together and the outcome will be unknown.

# All generated input variables will be of 'string' type as this is how Packer JSON
# views them; you can change their type later on. Read the variables type
# constraints documentation
# https://www.packer.io/docs/templates/hcl_templates/variables#type-constraints for more info.
variable "agent_tools_directory" {
  type    = string
  default = "C:\\hostedtoolcache\\windows"
}

variable "allowed_inbound_ip_addresses" {
  type    = string
  default = "${env("AGENT_IP")}"
}

variable "build_resource_group_name" {
  type    = string
  default = "${env("BUILD_RESOURCE_GROUP_NAME")}"
}

variable "client_id" {
  type    = string
  default = "${env("ARM_CLIENT_ID")}"
}

variable "client_secret" {
  type      = string
  default   = "${env("ARM_CLIENT_SECRET")}"
  sensitive = true
}

variable "gallery_image_name" {
  type    = string
  default = "${env("gallery_image_name")}"
}

variable "gallery_image_version" {
  type    = string
  default = "${env("gallery_image_version")}"
}

variable "gallery_name" {
  type    = string
  default = "${env("gallery_name")}"
}

variable "gallery_resource_group" {
  type    = string
  default = "${env("gallery_resource_group")}"
}

variable "helper_script_folder" {
  type    = string
  default = "C:\\Program Files\\WindowsPowerShell\\Modules\\"
}

variable "image_folder" {
  type    = string
  default = "C:\\image"
}

variable "image_os" {
  type    = string
  default = "win22"
}

variable "image_version" {
  type    = string
  default = "latest"
}

variable "imagedata_file" {
  type    = string
  default = "C:\\imagedata.json"
}

variable "install_password" {
  type      = string
  sensitive = true
}

variable "install_user" {
  type    = string
  default = "installer"
}

variable "location" {
  type    = string
  default = "${env("ARM_RESOURCE_LOCATION")}"
}

variable "managed_image_name" {
  type    = string
  default = "${env("managed_image_name")}"
}

variable "managed_image_resource_group_name" {
  type    = string
  default = "${env("managed_image_resource_group_name")}"
}

variable "object_id" {
  type    = string
  default = "${env("ARM_OBJECT_ID")}"
}

variable "private_virtual_network_with_public_ip" {
  type    = string
  default = "${env("PRIVATE_VIRTUAL_NETWORK_WITH_PUBLIC_IP")}"
}

variable "subscription_id" {
  type    = string
  default = "${env("ARM_SUBSCRIPTION_ID")}"
}

variable "temp_resource_group_name" {
  type    = string
  default = "${env("TEMP_RESOURCE_GROUP_NAME")}"
}

variable "tenant_id" {
  type    = string
  default = "${env("ARM_TENANT_ID")}"
}

variable "virtual_network_name" {
  type    = string
  default = "${env("VNET_NAME")}"
}

variable "virtual_network_resource_group_name" {
  type    = string
  default = "${env("VNET_RESOURCE_GROUP")}"
}

variable "virtual_network_subnet_name" {
  type    = string
  default = "${env("VNET_SUBNET")}"
}

variable "vm_size" {
  type    = string
  default = "Standard_D8s_v4"
}

# source blocks are generated from your builders; a source can be referenced in
# build blocks. A build block runs provisioner and post-processors on a
# source. Read the documentation for source blocks here:
# https://www.packer.io/docs/templates/hcl_templates/blocks/source
source "azure-arm" "autogenerated_1" {
  allowed_inbound_ip_addresses           = "${var.allowed_inbound_ip_addresses}"
  build_resource_group_name              = "${var.build_resource_group_name}"
  client_id                              = "${var.client_id}"
  client_secret                          = "${var.client_secret}"
  communicator                           = "winrm"
  image_offer                            = "WindowsServer"
  image_publisher                        = "MicrosoftWindowsServer"
  image_sku                              = "2022-Datacenter"
  location                               = "${var.location}"
  managed_image_name                     = "${var.managed_image_name}"
  managed_image_resource_group_name      = "${var.managed_image_resource_group_name}"
  object_id                              = "${var.object_id}"
  os_disk_size_gb                        = "256"
  os_type                                = "Windows"
  private_virtual_network_with_public_ip = "${var.private_virtual_network_with_public_ip}"
  shared_image_gallery_destination {
    gallery_name        = "${var.gallery_name}"
    image_name          = "${var.gallery_image_name}"
    image_version       = "${var.gallery_image_version}"
    replication_regions = ["${var.location}"]
    resource_group      = "${var.gallery_resource_group}"
    subscription        = "${var.subscription_id}"
  }
  subscription_id                     = "${var.subscription_id}"
  temp_resource_group_name            = "${var.temp_resource_group_name}"
  tenant_id                           = "${var.tenant_id}"
  virtual_network_name                = "${var.virtual_network_name}"
  virtual_network_resource_group_name = "${var.virtual_network_resource_group_name}"
  virtual_network_subnet_name         = "${var.virtual_network_subnet_name}"
  vm_size                             = "${var.vm_size}"
  winrm_insecure                      = "true"
  winrm_use_ssl                       = "true"
  winrm_username                      = "packer"
}

# a build block invokes sources and runs provisioning steps on them. The
# documentation for build blocks can be found here:
# https://www.packer.io/docs/templates/hcl_templates/blocks/build
build {
  sources = ["source.azure-arm.autogenerated_1"]

  provisioner "powershell" {
    inline = ["New-Item -Path ${var.image_folder} -ItemType Directory -Force"]
  }

  provisioner "file" {
    destination = "${var.helper_script_folder}"
    source      = "${path.root}/scripts/ImageHelpers"
  }

  provisioner "file" {
    destination = "${var.image_folder}"
    source      = "${path.root}/scripts/SoftwareReport"
  }

  provisioner "file" {
    destination = "${var.image_folder}/SoftwareReport/"
    source      = "${path.root}/../../helpers/software-report-base"
  }

  provisioner "file" {
    destination = "C:/"
    source      = "${path.root}/post-generation"
  }

  provisioner "file" {
    destination = "${var.image_folder}"
    source      = "${path.root}/scripts/Tests"
  }

  provisioner "file" {
    destination = "${var.image_folder}\\toolset.json"
    source      = "${path.root}/toolsets/toolset-2022.json"
  }

  provisioner "windows-shell" {
    inline = ["net user ${var.install_user} ${var.install_password} /add /passwordchg:no /passwordreq:yes /active:yes /Y", "net localgroup Administrators ${var.install_user} /add", "winrm set winrm/config/service/auth @{Basic=\"true\"}", "winrm get winrm/config/service/auth"]
  }

  provisioner "powershell" {
    inline = ["if (-not ((net localgroup Administrators) -contains '${var.install_user}')) { exit 1 }"]
  }

  provisioner "powershell" {
    elevated_password = "${var.install_password}"
    elevated_user     = "${var.install_user}"
    inline            = ["bcdedit.exe /set TESTSIGNING ON"]
  }

  provisioner "powershell" {
    environment_vars = ["IMAGE_VERSION=${var.image_version}", "IMAGE_OS=${var.image_os}", "AGENT_TOOLSDIRECTORY=${var.agent_tools_directory}", "IMAGEDATA_FILE=${var.imagedata_file}"]
    execution_policy = "unrestricted"
    scripts          = ["${path.root}/scripts/Installers/Configure-Antivirus.ps1", "${path.root}/scripts/Installers/Install-PowerShellModules.ps1", "${path.root}/scripts/Installers/Install-WindowsFeatures.ps1", "${path.root}/scripts/Installers/Install-Choco.ps1", "${path.root}/scripts/Installers/Initialize-VM.ps1", "${path.root}/scripts/Installers/Update-ImageData.ps1", "${path.root}/scripts/Installers/Update-DotnetTLS.ps1"]
  }

  provisioner "windows-restart" {
    check_registry        = true
    restart_check_command = "powershell -command \"& {while ( (Get-WindowsOptionalFeature -Online -FeatureName Containers -ErrorAction SilentlyContinue).State -ne 'Enabled' ) { Start-Sleep 30; Write-Output 'InProgress' }}\""
    restart_timeout       = "10m"
  }

  provisioner "powershell" {
    scripts = ["${path.root}/scripts/Installers/Install-Docker.ps1", "${path.root}/scripts/Installers/Install-PowershellCore.ps1", "${path.root}/scripts/Installers/Install-WebPlatformInstaller.ps1"]
  }

  provisioner "windows-restart" {
    restart_timeout = "30m"
  }

  provisioner "powershell" {
    elevated_password = "${var.install_password}"
    elevated_user     = "${var.install_user}"
    scripts           = ["${path.root}/scripts/Installers/Install-VS.ps1", "${path.root}/scripts/Installers/Install-KubernetesTools.ps1"]
    valid_exit_codes  = [0, 3010]
  }

  provisioner "windows-restart" {
    check_registry  = true
    restart_timeout = "10m"
  }

  provisioner "powershell" {
    pause_before = "2m0s"
    scripts      = ["${path.root}/scripts/Installers/Install-Wix.ps1", "${path.root}/scripts/Installers/Install-WDK.ps1", "${path.root}/scripts/Installers/Install-Vsix.ps1", "${path.root}/scripts/Installers/Install-AzureCli.ps1", "${path.root}/scripts/Installers/Install-AzureDevOpsCli.ps1", "${path.root}/scripts/Installers/Install-CommonUtils.ps1", "${path.root}/scripts/Installers/Install-JavaTools.ps1", "${path.root}/scripts/Installers/Install-Kotlin.ps1"]
  }

  provisioner "powershell" {
    execution_policy = "remotesigned"
    scripts          = ["${path.root}/scripts/Installers/Install-ServiceFabricSDK.ps1"]
  }

  provisioner "windows-restart" {
    restart_timeout = "10m"
  }

  provisioner "windows-shell" {
    inline = ["wmic product where \"name like '%%microsoft azure powershell%%'\" call uninstall /nointeractive"]
  }

  provisioner "powershell" {
    scripts = ["${path.root}/scripts/Installers/Install-Ruby.ps1", "${path.root}/scripts/Installers/Install-PyPy.ps1", "${path.root}/scripts/Installers/Install-Toolset.ps1", "${path.root}/scripts/Installers/Configure-Toolset.ps1", "${path.root}/scripts/Installers/Install-NodeLts.ps1", "${path.root}/scripts/Installers/Install-AndroidSDK.ps1", "${path.root}/scripts/Installers/Install-AzureModules.ps1", "${path.root}/scripts/Installers/Install-Pipx.ps1", "${path.root}/scripts/Installers/Install-PipxPackages.ps1", "${path.root}/scripts/Installers/Install-Git.ps1", "${path.root}/scripts/Installers/Install-GitHub-CLI.ps1", "${path.root}/scripts/Installers/Install-PHP.ps1", "${path.root}/scripts/Installers/Install-Rust.ps1", "${path.root}/scripts/Installers/Install-Sbt.ps1", "${path.root}/scripts/Installers/Install-Chrome.ps1", "${path.root}/scripts/Installers/Install-Edge.ps1", "${path.root}/scripts/Installers/Install-Firefox.ps1", "${path.root}/scripts/Installers/Install-Selenium.ps1", "${path.root}/scripts/Installers/Install-IEWebDriver.ps1", "${path.root}/scripts/Installers/Install-Apache.ps1", "${path.root}/scripts/Installers/Install-Nginx.ps1", "${path.root}/scripts/Installers/Install-Msys2.ps1", "${path.root}/scripts/Installers/Install-WinAppDriver.ps1", "${path.root}/scripts/Installers/Install-R.ps1", "${path.root}/scripts/Installers/Install-AWS.ps1", "${path.root}/scripts/Installers/Install-DACFx.ps1", "${path.root}/scripts/Installers/Install-MysqlCli.ps1", "${path.root}/scripts/Installers/Install-SQLPowerShellTools.ps1", "${path.root}/scripts/Installers/Install-SQLOLEDBDriver.ps1", "${path.root}/scripts/Installers/Install-DotnetSDK.ps1", "${path.root}/scripts/Installers/Install-Mingw64.ps1", "${path.root}/scripts/Installers/Install-Haskell.ps1", "${path.root}/scripts/Installers/Install-Stack.ps1", "${path.root}/scripts/Installers/Install-Miniconda.ps1", "${path.root}/scripts/Installers/Install-AzureCosmosDbEmulator.ps1", "${path.root}/scripts/Installers/Install-Mercurial.ps1", "${path.root}/scripts/Installers/Install-Zstd.ps1", "${path.root}/scripts/Installers/Install-NSIS.ps1", "${path.root}/scripts/Installers/Install-Vcpkg.ps1", "${path.root}/scripts/Installers/Install-PostgreSQL.ps1", "${path.root}/scripts/Installers/Install-Bazel.ps1", "${path.root}/scripts/Installers/Install-AliyunCli.ps1", "${path.root}/scripts/Installers/Install-RootCA.ps1", "${path.root}/scripts/Installers/Install-MongoDB.ps1", "${path.root}/scripts/Installers/Install-CodeQLBundle.ps1", "${path.root}/scripts/Installers/Disable-JITDebugger.ps1"]
  }

  provisioner "powershell" {
    elevated_password = "${var.install_password}"
    elevated_user     = "${var.install_user}"
    scripts           = ["${path.root}/scripts/Installers/Install-WindowsUpdates.ps1", "${path.root}/scripts/Installers/Configure-DynamicPort.ps1", "${path.root}/scripts/Installers/Configure-GDIProcessHandleQuota.ps1", "${path.root}/scripts/Installers/Configure-Shell.ps1", "${path.root}/scripts/Installers/Enable-DeveloperMode.ps1", "${path.root}/scripts/Installers/Install-LLVM.ps1"]
  }

  provisioner "windows-restart" {
    check_registry        = true
    restart_check_command = "powershell -command \"& {if ((-not (Get-Process TiWorker.exe -ErrorAction SilentlyContinue)) -and (-not [System.Environment]::HasShutdownStarted) ) { Write-Output 'Restart complete' }}\""
    restart_timeout       = "30m"
  }

  provisioner "powershell" {
    pause_before = "2m0s"
    scripts      = ["${path.root}/scripts/Installers/Wait-WindowsUpdatesForInstall.ps1", "${path.root}/scripts/Tests/RunAll-Tests.ps1"]
  }

  provisioner "powershell" {
    inline = ["if (-not (Test-Path ${var.image_folder}\\Tests\\testResults.xml)) { throw '${var.image_folder}\\Tests\\testResults.xml not found' }"]
  }

  provisioner "powershell" {
    environment_vars = ["IMAGE_VERSION=${var.image_version}"]
    inline           = ["pwsh -File '${var.image_folder}\\SoftwareReport\\SoftwareReport.Generator.ps1'"]
  }

  provisioner "powershell" {
    inline = ["if (-not (Test-Path C:\\software-report.md)) { throw 'C:\\software-report.md not found' }", "if (-not (Test-Path C:\\software-report.json)) { throw 'C:\\software-report.json not found' }"]
  }

  provisioner "file" {
    destination = "${path.root}/Windows2022-Readme.md"
    direction   = "download"
    source      = "C:\\software-report.md"
  }

  provisioner "file" {
    destination = "${path.root}/software-report.json"
    direction   = "download"
    source      = "C:\\software-report.json"
  }

  provisioner "powershell" {
    environment_vars = ["INSTALL_USER=${var.install_user}"]
    scripts          = ["${path.root}/scripts/Installers/Run-NGen.ps1", "${path.root}/scripts/Installers/Finalize-VM.ps1"]
    skip_clean       = true
  }

  provisioner "windows-restart" {
    restart_timeout = "10m"
  }

  provisioner "powershell" {
    inline = ["if( Test-Path $Env:SystemRoot\\System32\\Sysprep\\unattend.xml ){ rm $Env:SystemRoot\\System32\\Sysprep\\unattend.xml -Force}", "& $env:SystemRoot\\System32\\Sysprep\\Sysprep.exe /oobe /generalize /mode:vm /quiet /quit", "while($true) { $imageState = Get-ItemProperty HKLM:\\SOFTWARE\\Microsoft\\Windows\\CurrentVersion\\Setup\\State | Select ImageState; if($imageState.ImageState -ne 'IMAGE_STATE_GENERALIZE_RESEAL_TO_OOBE') { Write-Output $imageState.ImageState; Start-Sleep -s 10  } else { break } }"]
  }

}
