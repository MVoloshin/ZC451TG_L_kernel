MTK_HOOK_RELEASE_ALL_CHECK_ITEM := LOCAL_2ND_ARCH_VAR_PREFIX
MTK_HOOK_RELEASE_ALL_CHECK_ITEM += LOCAL_CERTIFICATE
MTK_HOOK_RELEASE_ALL_CHECK_ITEM += LOCAL_IS_HOST_MODULE
MTK_HOOK_RELEASE_ALL_CHECK_ITEM += LOCAL_MODULE
MTK_HOOK_RELEASE_ALL_CHECK_ITEM += LOCAL_MODULE_CLASS
MTK_HOOK_RELEASE_ALL_CHECK_ITEM += LOCAL_MODULE_PATH
MTK_HOOK_RELEASE_ALL_CHECK_ITEM += LOCAL_MODULE_PATH_32
MTK_HOOK_RELEASE_ALL_CHECK_ITEM += LOCAL_MODULE_PATH_64
MTK_HOOK_RELEASE_ALL_CHECK_ITEM += LOCAL_MODULE_RELATIVE_PATH
MTK_HOOK_RELEASE_ALL_CHECK_ITEM += LOCAL_MODULE_STEM
MTK_HOOK_RELEASE_ALL_CHECK_ITEM += LOCAL_MODULE_STEM_32
MTK_HOOK_RELEASE_ALL_CHECK_ITEM += LOCAL_MODULE_STEM_64
MTK_HOOK_RELEASE_ALL_CHECK_ITEM += LOCAL_MODULE_SUFFIX
MTK_HOOK_RELEASE_ALL_CHECK_ITEM += LOCAL_MODULE_TAGS
MTK_HOOK_RELEASE_ALL_CHECK_ITEM += LOCAL_MULTILIB
MTK_HOOK_RELEASE_ALL_CHECK_ITEM += LOCAL_PACKAGE_NAME
MTK_HOOK_RELEASE_ALL_CHECK_ITEM += LOCAL_PATH
MTK_HOOK_RELEASE_ALL_CHECK_ITEM += LOCAL_REQUIRED_MODULES
MTK_HOOK_RELEASE_ALL_CHECK_ITEM += LOCAL_SHARED_LIBRARIES
MTK_HOOK_RELEASE_ALL_CHECK_ITEM += LOCAL_SHARED_LIBRARIES_32
MTK_HOOK_RELEASE_ALL_CHECK_ITEM += LOCAL_SHARED_LIBRARIES_64
MTK_HOOK_RELEASE_ALL_CHECK_ITEM += LOCAL_IS_STATIC_JAVA_LIBRARY
MTK_HOOK_RELEASE_ALL_CHECK_ITEM += TARGET_2ND_ARCH
MTK_HOOK_RELEASE_ALL_CHECK_ITEM += HOST_2ND_ARCH
MTK_HOOK_RELEASE_ALL_CHECK_ITEM += my_32_64_bit_suffix
MTK_HOOK_RELEASE_ALL_CHECK_ITEM += my_register_name-hook

#release hook
define base-rules-dump-release-info-hook
# Keep all module info for release
$(eval \
my_prefix-hook := $$(if $$(LOCAL_IS_HOST_MODULE),HOST_,TARGET_)
my_register_name-hook := $$(if $$(LOCAL_2ND_ARCH_VAR_PREFIX),$$(if $$(LOCAL_NO_2ND_ARCH_MODULE_SUFFIX),$$(LOCAL_MODULE),$$(LOCAL_MODULE)$$($$(my_prefix)2ND_ARCH_MODULE_SUFFIX)),$$(LOCAL_MODULE))
module_id-hook := MODULE.$$(if $$(LOCAL_IS_HOST_MODULE),HOST,TARGET).$$(LOCAL_MODULE_CLASS).$$(my_register_name-hook)
my_32_64_bit_suffix := $$(if $$($$(LOCAL_2ND_ARCH_VAR_PREFIX)$$(my_prefix)IS_64_BIT),64,32)
MTK_HOOK_ALL_MODULE_ID := $$(MTK_HOOK_ALL_MODULE_ID) $$(module_id-hook)
)
$(foreach CHECK_ITEM,$(MTK_HOOK_RELEASE_ALL_CHECK_ITEM),$(eval MTK_HOOK_$$(module_id-hook)_$$(CHECK_ITEM):= $$($$(CHECK_ITEM))))

endef

define base-rules-hook
$(call base-rules-dump-release-info-hook)
endef

