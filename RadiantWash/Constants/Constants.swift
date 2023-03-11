//
//  Constants.swift
//  RadiantWash
//
//  Created by Mac Mini on 17.02.2023.
//

import UIKit

typealias C = Constants
class Constants {
  
  struct project {
    static let appleID = "id6446185264"
    static let appID = "6446185264"
    static let appStoreName = "CleanWizard"
    static let storeSecretKey = "e379ad4a39794a1c8fa4b9e9f1807c37"
    static let appBundle = "com.cleanwizardapp.cleanwizard"
    static let mail = "cleanwizardsupr@gmail.com"
  }
  
  struct web {
    static let policy = "https://www.cleanwizardapp.com/privacy-policy"
    static let terms = "https://www.cleanwizardapp.com/terms-of-use"
    static let shareApp = URL(string: "https://apps.apple.com/us/app")!//old
    static let contact = "https://www.cleanwizardapp.com"//old
  }
  
  struct gadAdvertisementKey {
    /**
     - parameter GADApplicationIdentifier use in info.plist file
     - parameter gadProductionKey use when app in production
     */
    
    static let GADApplicationIdentifier = "ca-app-pub-2414191652218286~1983949714"
    static let gadProductionKey = "ca-app-pub-2414191652218286/8166214686"
    static let gadInterstitialProductionKey = "ca-app-pub-2414191652218286/8278180734"
    static let gadRewardedIntProductionKey = "ca-app-pub-2414191652218286/7819564477"
    static let gadRewardedProductionKey = "ca-app-pub-2414191652218286/7819564477"
    
//    static let GADTestAppIdentifier = "ca-app-pub-3940256099942544~1458002511"
    static let gadTestKey = "ca-app-pub-3940256099942544/2934735716"
    static let gadInterstitialTestKey = "ca-app-pub-3940256099942544/4411468910"
    static let gadRewardedTestKey = "ca-app-pub-3940256099942544/1712485313"
    static let gadRewardedIntTestKey = "ca-app-pub-3940256099942544/6978759866"
    
    static let advertisementViewTag: Int = 666
  }
  
  struct key {
    
    struct keyDescriptor {
      static let telegram = "Telegram"
    }
    
    struct advertisement {
      static let bannerDidShow = "advertisementBannerDidShow"
      static let bannerStatus = "advertisementBannerStatus"
    }
    
    struct application {
      static let applicationLastUsage = "applicationLastUsage"
      static let applicationFirstTimeStart = "applicationFirstTimeStart"
      
      static let applicationRoutingKey = "com.cleanerApplicationRouting.Key"
      
      static let onboardingValue      = "com.cleaner.tryPassOnboarding.key"
      static let permissionValue      = "com.cleaner.tryPassPermission.key"
      static let subscriptionValue    = "com.cleaner.tryPassSubscription.key"
      static let aplicationValue       = "com.cleaner.tryAplication.key"
      
      static let subscriptionDevelopmentStatus = "com.cleaner.development.applicationSubscription.status"
    }
    
    struct subscription {
      static let purchasePremium = "purchasePremium"
      static let subscriptionExpireDate = "subscriptionExpireDate"
      static let expiredSubscription = "expiredSubscription"
      static let verificationPassed = "verificationPassed"
      static let subscriptionID = "currentSubscriptionID"
    }
    
    struct permissions {
      static let settingsPhotoPermission = "photoPermissionValue"
      static let settingsContactsPermission = "contactePermissionValue"
      
      struct rawValue {
        static let notification = "com.cleaner.permission.notification"
        static let photolibrary = "com.cleaner.permission.photolibrary"
        static let contacts = "com.cleaner.permission.contacts"
        static let tracking = "com.cleaner.permission.tracking"
        static let appUsage = "com.cleaner.permission.appUsage"
        static let blank = "com.cleaner.permission.blank"
      }
    }
    
    struct contacts {
      struct groupSorting {
        static let name = "com.cleaner.contactsGroup.name"
        static let phone = "com.cleaner.contactsGroup.phone"
        static let mail = "com.cleaner.contactsGroup.mail"
        static let emptyName = "com.cleaner.contactsGroup.emptyName"
        static let empty = "com.cleaner.contactsGroup.empty"
        static let telegram = "com.cleaner.contactsGroup.telegram"
      }
    }
    
    struct localUserNotification {
      static let localNotificationRawValue = "localnotifactionRawValue"
    }
    
    struct settings {
      static let isDarkModeOn = "darkModeIsSetOn"
      static let photoLibraryAccessGranted = "photoLibraryAccessGranted"
      static let contactStoreAccessGranted = "contactStoreAccessGranted"
      static let lowerBoundSavedDate = "lowerBoundSavedDate"
      static let upperBoundSavedDate = "upperBoundSavedDate"
      static let lastSmartClean = "lastSmartClean"
      static let largeVideoLowerSize = "largeVideoLowerSize"
      
      static let photoSpace = "photoDiskSpace"
      static let videoSpace = "videoDiskSpace"
      static let allMediaSpace = "wholeAssetsDiskSpace"
      
      struct promt {
        static let promtDelay = "promtDelay"
        static let promtTriger = "promtTriger"
        static let sixHoursDelay = "sixHoursPromtDelay"
        static let firstTimePromtShow = "firstTimePromtShow"
      }
    }
    
    struct compressionSettings {
      static let videoBitrate = "videoBitrate"
      static let audioBitrate = "audioBitrate"
      static let fps = "videoFPS"
      static let frameInterval = "maximumVideoKeyframeInterval"
      static let resolutionWidth = "scaleResolutionWidth"
      static let resolutionHeight = "scaleResolutionHeight"
      static let defaultConfigurationIsSet = "defaultConfigurationIsSet"
      static let lastSelectedCompressionModel = "selectedCompressionModel"
      static let originalResolutionIsOnUse = "originalResolutionIsOnUse"
    }
    
    struct localIdentifiers {
      static let lastSavedNewLocalIdentifier = "lastSavedLocalIdentifier"
    }
    
    struct notification {
      
      /// `phasset disk space update notification name`
      static let photoSpaceNotificationName = "photoSpaceDidChange"
      static let videoSpaceNotificationName = "videoSpaceDidChange"
      static let mediaSpaceNotificationName = "mediaSpaceDidChange"
      static let contactsCountNotificationName = "contactsCountDidChange"
      static let removeStoreObserver = "removeStoreObserver"
      static let addStoreObserver = "addStoreObserver"
      
      static let permissionDidChange = "permissionDidChange"
      static let forceStopProcessing = "forceStopProcessingStartHandleReciveRemoteCleanAction"
      static let networking = "networkingStatusDidChange"
      static let bannerStatus = "bannerStatusDidChange"
      
      /// `deep clean update progress notification name`
      struct deepClean {
        /// photo
        static let deepCleanSimilarPhotoPhassetScan = "deepCleanSimilarPhotoPhassetScan"
        static let deepCleanDuplicatedPhotoPhassetScan = "deepCleanDuplicatedPhotoPhassetScan"
        static let deepCleanScreenShotsPhotoPhassetScan = "deepCleanScreenShotsPhassetScan"
        static let deepCleanSimilarSelfiesPhotoPhassetScan = "deepCleanSimilarSelfiesPhotoPhassetScan"
        static let deepCleanSimilarLivePhotosPhassetScan = "deepCleanSimilarLivePhotosPhaassetScan"
        static let deepCleanLargeVideoPhassetScan = "deepCleanLargeVideoPhassetScan"
        /// video
        static let deepCleanDuplicateVideoPhassetScan = "deepCleanDuplicateVideoPhassetScan"
        static let deepCleanSimilarVideoPhassetScan = "deepCleanSimilarVideoPhassetScan"
        static let deepCleanScreenRecordingsPhassetScan = "deepCleanScreenRecordingsPhassetScant"
        /// contacts
        static let deepCleanEmptyContactsScan = "deepCleanEmptyContactsScan"
        static let deepCleanDuplicatedContactsScan = "deepCleanDuplicatedContactsScan"
        static let deepCleanDuplicatedPhoneNumbersScan = "deepCleanDuplicatedPhoneNumbersScan"
        static let deepCleanDupLicatedMailsScan = "deepCleanDupLicatedEmaailScan"
        
        static let deepCleanPhotoFilesSizeScan = "deepCleanPhotoFilesSizeScan"
        static let deepCleanVideoFilesSizeScan = "deepCleanVideoFilesSizeScan"
      }
      
      /// `single Search update progress notification name`
      struct singleSearch {
        /// contacts
        static let singleSearchAllContactsScan = "singleSearchAllContactsScan"
        static let singleSearchEmptyContactsScan = "singleSearchEmptyContactsScan"
        static let singleSearchDuplicatesNamesContactsScan = "singleSearchDuplicatesNamesContactsScan"
        static let singleSearchDuplicatesNumbersContactsScan = "singleSearchDuplicatesNumbersContactsScan"
        static let singleSearchDupliatesEmailsContactsScan = "singleSearchDupliatesEmailsContactsScan"
        /// photo
        static let singleSearchSimilarPhotoPHAssetScan = "singleSearchSimilarPhotoPhassetScan"
        static let singleDuplicatedPhotoPHAssetScan = "singleDuplicatedPhotoPHAssetScant"
        static let singleSimilarLivePhotoPHAssetScan = "singleSimilarLivePhotoPHAssetScan"
        static let singleScreeenshotsPhotoPHAssetScan = "singleScreeenshotsPhotoPHAssetScan"
        static let singleSimilarSelfiesPHassetScan = "singleSimilarSelfiesPHassetScan"
        static let singleLivePhotoPHAssetScan = "singleLivePhotoPHAssetScan"
        static let singleRecentlyDeletedPHAssetScan = "singleRecentlyDeletedPHAssetScan"
        /// video
        static let singleLargeVideoPHAssetScan = "singleLargeVideoPHAssetScan"
        static let singleDuplicatedVideoPHAssetScan = "singleDuplicatedVideoPHAssetScan"
        static let singleSimilarVideoPHAssetScan = "singleSimilarVideoPHAssetScan"
        static let singleScreenRecordingsVideoPHAssetScan = "singleScreenRecordingsVideoPHAssetScan"
        static let singleRecentlyDeleteVideoPHAssetScan = "singleRecentlyDeleteVideoPHAssetScan"
        
        static let singleOperationPhotoFilesSizeScan = "singleOperationPhotoFilesSizeScan"
        static let singleOperationVideoFilesSizeScan = "singleOperationVideoFilesSizeScan"
      }
      
      /// `contacts notification`
      static let mergeContactsSelectionDidChange = "mergeContactsSelectionDidChange"
      static let selectedContactsDidChange = "selectedContactsDidChange"
      
      /// `compression notification`
      static let compressionDidStart = "CompressionVideoFileDidStartNotification"
      static let compressionProgress = "CompressionVideoProgressNotification"
      
      struct name {
        static let photoClean = "didSendCleanPhotoContentNotification"
        static let videoClean = "didSendCleanVideoContentNotification"
        static let contactsClean = "didSendCleanContactsContentNotification"
        static let deepClean = "didSendDeepCleanContentNotification"
        static let clean = "didSendCleanContentnotification"
      }
      
      struct identifier {
        static let photoClean = "com.cleaner.photoClean"
        static let videoClean = "con.cleaner.videoClean"
        static let contactsClean = "com.cleaner.contactsClean"
        static let deepClean = "com.cleaner.deepClean"
        static let clean = "com.cleaner.clean"
      }
      
      struct request {
        static let photoClean = "com.cleaner.request.photoClean"
        static let videoClean = "con.cleaner.request.videoClean"
        static let contactsClean = "com.cleaner.request.contactsClean"
        static let deepClean = "com.cleaner.requestdeepClean"
        static let clean = "com.cleaner.requestClean"
      }
      
      struct notificationAction {
        static let decline = "com.cleaner.actions.declinenotificationAction"
        static let similarPhotoCleanAction = "com.cleaner.action.similarPhotoCleanAction"
        static let duplicatedPhotoCleanAction = "com.cleaner.action.duplicatedPhotoCleanAction"
        static let similarVideCleanAction = "com.cleaner.action.similarVideoCleanAction"
        static let duplicatedVideoCleanAction = "com.cleaner.action.duplicatedVideoCleanAction"
        static let duplicatedContectsCleanAction = "com.cleaner.action.duplicatedContactsCleanActions"
        static let deepClean = "com.cleaner.actions.deepCleanNotificationAction"
      }
      
      struct shortCutAction {
        static let photoScan = "com.cleaner.actions.photoScan"
        static let videoScan = "com.cleaner.actions.videoScan"
        static let contactsScan = "com.cleaner.actions.contactScan"
      }
    }
    
    struct observers {
      
      struct player {
        static let duration = "duration"
        static let playerLayer = "playerLayer"
      }
    }
    
    struct dispatch {
      static let mergeContactsQueue = "com.contacts.merge_queue"
      static let deleteContactsQueue = "com.contacts.delete_queue"
      static let selectedPhassetsQueue = "com.photo.selectedPHAssets_queue"
      static let compressVideoQueue = "com.video.compressVideo_queue"
      static let compressAudieQueue = "com.audio.compressAudio_queue"
      static let animatedProgressQueue = "com.progressAlert.progressBar_queue"
      static let getPhotoFileSize = "com.photo.getFileSize_queue"
      static let getVideoFileSize = "com.video.getFileSize_queue"
      static let clusteringQueue = "com.photo.map_annotation_queue"
      static let parsingLocations = "com.photo.locatioonsParsing"
    }
    
    struct operation {
      
      struct queue {
        static let contacts = "contactsCleanSearchOperationQueuer"
        static let phassets = "phassetsCleanSearchOperationQueuer"
        static let deepClean = "deepCleanSearchOperationQueuer"
        static let smartClean = "smartCleanSearchOperationQueuer"
        static let cleaningProcess = "cleaningProcessOprationQueuer"
        static let utils = "backgroundUtitlityQueuer"
        static let preetchPHasssetQueue = "prefetchPhassetsImagesOperationQueuer"
        static let techUseQueue = "technicalUseProcessingOperationQueuer"
      }
      
      struct name {
        
        /// `contacts`
        static let updateContectContacts = "updateBaseContactsOperation"
        static let mergeContacts = "mergeContactsOperation"
        static let deleteContacts = "deleteContactsOperation"
        
        static let emptyContacts = "emptyContactsOperation"
        static let duplicatedContacts = "duplicatedContactsOperation"
        static let phoneDuplicated = "phoneDuplicatedOperation"
        static let emailDuplicated = "emailDuplicatedOperation"
        
        /// `system phassets`
        static let phassetSingleSizes = "getCalculatePHAssetSizesSingleOperation"
        static let phassetAllSizes = "getCalculatedAllPHAssetSizeOperation"
        static let fetchPHAssetCount = "fetchTotalPHAssetsOperation"
        static let fetchFromGallery = "fetchFromGalleryOperation"
        
        static let similarPhotoProcessingOperation = "similarPhotoProcessingOperation"
        static let duplicatePhotoProcessingOperation = "duplicatePhotoProcessingOperation"
        static let screenShotsOperation = "screenShotsOperation"
        static let livePhotoOperation = "livePhotoOperation"
        static let similarSelfiesOperation = "similarSelfiesOperation"
        static let similarLivePhotoProcessingOperation = "similarLivePhotoProcessingOperation"
        
        static let recentlyDeletedAlbums = "recentlyDeletedAlbumFetchOperation"
        static let recentlyDeletedSortedAlbums = "recentlyDeletedSortedAlbumsFetchOperation"
        static let deletePhassetsOperation = "deletePhassetsOperation"
        static let recoverPhassetsOperation = "recoverPhassetsOperation"
        
        static let videoCountOperation = "calculateTotalVideoProcessingOperation"
        static let photoCouuntOperation = "calculateTotlaPhotoProcessingOperation"
        static let screenRecordingOperation = "screenRecordsVideosOperation"
        
        static let largeVideo = "largeVideoOperation"
        static let similarVideoProcessingOperation = "similarVideoProcessingOperation"
        static let duplicateVideoProcessingOperation = "duplicateVideoProcessingOperation"
        
        static let similarTuplesOperation = "serviceUtilitySimilarTuplesOperation"
        static let duplicatedTuplesOperation = "serviceUtilityDuplicatedTuplesOperation"
        static let findDuplicatedVideoOperation = "findDuplicatedVideoOperation"
        static let getSimilarVideosByTimeStampOperation = "getSimilarVideosByTimeStampOperation"
        
        /// `deep clean`
        static let deepCleanProcessingCleaningOperation = "deepCleanProcessingCleaningOperation"
        /// `prefetch phassets`
        static let prefetchPHAssetsOperation = "prefetchPHassetsOperation"
        /// `find duplicated assets and indexes`
        static let analizeDuplicatedPHAssetsIndexPathsSearch = "analizeDuplicatedPHAssetsIndexPathsSearch"
        
        static let phassetsEstimatedSizeOperation = "phassetsEstimatedSizeOperation"
        static let avassetEstimatedSizeOperation = "avassetEstimatedSizeOperation"
      }
    }
    
    //        MARK: - notification dictionary progress identifiers -
    /**
     use for notification info dictionary for update progress of deepCleanNotification
     - parameter `index` use for detect current progrss index
     - parameter `count` use for detect total assets count in progress
     */
    
    struct notificationDictionary {
      
      struct permission {
        static let photoPermission = "photoPermissionDidChangeNotificationDictionary"
        static let contactsPermission = "contactsPermissionDidChangeNotificationDictionary"
      }
      
      /// `INDEXES`
      struct index {
        /// photo part
        static let similarPhotoIndex = "deepCleanPhotoPrecessIndex"
        static let duplicatePhotoIndex = "deepCleanDuplicatePhotoProcessingIndex"
        static let screenShotsIndex = "deepCleanscreenShotsProcessingIndex"
        static let livePhotosIndex = "deepCleanlivePhotosProcessingIndex"
        static let similarSelfiePhotoIndex = "similarSelfiePhotoProcessingIndex"
        static let recentlyDeletedPhotoIndex = "recentlyDeletedPhotoProcessingIndex"
        /// video part
        static let largeVideoIndex = "deepCleanlargeVideoProcessingIndex"
        static let duplicateVideoIndex = "deepCleanduplicateVideoProcessingIndex"
        static let similarVideoIndex = "deepCleansimilarVideoProcessingIndex"
        static let screenRecordingsIndex = "deepCleanscreenRecordingsProcessingIndex"
        static let recentrlyDeletedVideoIndex = "recentrlyDeletedVideoProcessingIndex"
        /// contacts part
        static let allContactsIndex = "deepCleanallContactsProcessingIndex"
        static let emptyContactsIndex = "deepCleanemptyContactsProcessingIndex"
        static let duplicateNamesContactsIndex = "duplicateNamesContactsProcessingIndex"
        static let duplicateNumbersContactsIndex = "duplicateNumbersContactsProcessingIndex"
        static let duplicateEmailContactsIndex = "duplicateEmailContactsProcessingIndex"
        
        static let photoProcessingIndex = "photoProcessingIndex"
        static let videoProcessingIndex = "videoProcessingIndex"
        
        static let videoProcessingFrame = "videoProcessingFrame"
      }
      
      /// `TOTAL COUNT`
      struct count {
        
        static let similarPhotoCount = "deepCleanSimilarPhotoTotalAsssetsCount"
        static let duplicatePhotoCount = "deepCleanDuplicatePhotoTotalAssetsCount"
        static let screenShotsCount = "deepCleanscreenShotsCount"
        static let livePhotosSimilarCount = "deepCleanlivePhotosCount"
        static let similarSelfiePhotosCount = "similarSelfiePhotosCount"
        static let recentlyDeletedPhotoCount = "recentlyDeletedPhotoCount"
        /// video part
        static let largeVideoCount = "deepCleanlargeVideoCount"
        static let duplicateVideoCount = "deepCleanduplicateVideoCount"
        static let similarVideoCount = "deepCleansimilarVideoCount"
        static let screenRecordingsCount = "deepCleanscreenRecordingsCount"
        static let recentlyDeletedVideoCount = "recentlyDeletedVideoCount"
        /// contacts part
        static let allContactsCount = "deepCleanallContactsCount"
        static let emptyContactsCount = "deepCleanemptyContactsCount"
        static let duplicateNamesContactsCount = "duplicateNamesContactsCount"
        static let duplicateNumbersContactsCount = "duplicateNumbersContactsCount"
        static let duplicateEmailsContactsCount = "duplicateEmailsContactsCount"
        
        static let photoProcessingCount = "photoProcessingCount"
        static let videoProcessingCount = "videoProcessingCount"
        
        static let videoProcessingFramesCount = "videoProcessingFramesCount"
      }
      /// `STATE`
      struct state {
        static let similarPhotoState = "deepCleanPhotoPrecessState"
        static let duplicatePhotoState = "deepCleanDuplicatePhotoProcessingState"
        static let screenShotsState = "deepCleanscreenShotsProcessingState"
        static let livePhotosState = "deepCleanlivePhotosProcessingState"
        static let similarLivePhototState = "deepCleanSimiliarLivePhotoState"
        static let similarSelfieState = "similarSelfiePhotoProcessingState"
        static let recentlyDeletedPhotoState = "recentlyDeletedPhotoProcessingState"
        /// video part
        static let largeVideoState = "deepCleanlargeVideoProcessingState"
        static let duplicateVideoState = "deepCleanduplicateVideoProcessingState"
        static let similarVideoState = "deepCleansimilarVideoProcessingState"
        static let screenRecordingsState = "deepCleanscreenRecordingsProcessingState"
        static let recentrlyDeletedVideoState = "recentrlyDeletedVideoProcessingState"
        /// contacts part
        static let allContactsState = "deepCleanallContactsProcessingState"
        static let emptyContactsState = "deepCleanemptyContactsProcessingState"
        static let duplicateNamesContactsState = "duplicateNamesContactsProcessingState"
        static let duplicateNumbersContactsState = "duplicateNumbersContactsProcessingState"
        static let duplicateEmailContactsState = "duplicateEmailContactsProcessingState"
      }
      
      struct value {
        static let photoFilesSizeValue = "photoFilesSizeValue"
        static let videoFileSizeValue = "videoFileSizeValue"
      }
      
      struct scroll {
        /// contact scroll delegate scriklkub
        static let scrollViewInset = "scrollViewInset"
        static let scrollViewOffset = "scrollViewOffset"
      }
      
      struct progressAlert {
        static let progrssAlertValue = "progressAlertValue"
        static let progressAlertFilesCount = "progressAlertFilesCount"
        
        static let deepCleanProgressValue = "deepCleanProgressValue"
        static let deepCleanProcessingChangedTitle = "deepCleanProcessingChangedTitle"
      }
    }
  }
  
  //    MARK: - public identifiers -
  struct identifiers {
    
    struct navigation {
      static let main = "StartingNavigationBar"
      static let navigationBar = "NavigationBar"
      static let subscription = "PremiumNavigationBar"
    }
    
    struct storyboards {
      static let main = "Main"
      static let media = "MediaContent"
      static let deep = "DeepClean"
      static let preview = "MediaPreview"
      static let contacts = "Contacts"
      static let contactsGroup = "ContactsGroup"
      static let exportContacts = "ExportContact"
      static let settings = "Settings"
      static let videoProcessing = "VideoProcessing"
      static let permissions = "Permissions"
      static let onboarding = "Onboarding"
      static let subscription = "Subscription"
      static let location = "Location"
      static let web = "Web"
    }
    
    struct viewControllers {
      static let advertise = "AdvertisementController"
      static let main = "MainController"
      static let content = "MediaContentController"
      static let datePicker = "DateSelectorController"
      static let assetsList = "AssetsListController"
      static let groupedList = "GroupedAssetListController"
      static let media = "MediaController"
      static let videoCompressCollection = "VideoCollectionCompressingController"
      static let videoCompressing = "VideoCompressingController"
      static let contacts = "ContactsController"
      static let deepClean = "DeepCleaningController"
      static let contactsGroup = "ContactsGroupController"
      static let expordContacts = "ExportContactsController"
      static let settings = "SettingsController"
      static let customCompression = "VideoCompressionController"
      static let permissions = "PermissionsController"
      static let onboarding = "OnboardingController"
      static let onboardingPage = "OnboardingPageController"
      static let subscription = "SubscriptionController"
      static let lifeTime = "LifeTimeSubscriptionController"
      static let contactBackup = "BackupContactsController"
      static let contactsInfo = "ContactsInfoController"
      static let location = "LocationController"
      static let locationGrid = "LocationGridController"
      static let locationInfo = "LocationInfoController"
      static let web = "WebController"
    }
    
    struct cells {
      static let mediaTypeCell = "MediaTypeCell"
      static let contentTypeCell = "ContentTypeCell"
      static let photoSimpleCell = "PhotoCell"
      static let photoPreviewCell = "PhotoPreviewCell"
      static let dropDownCell = "DropDownMenuCell"
      static let cleanInfoCell = "DeepCleanInfoCell"
      static let contactCell = "ContactCell"
      static let groupContactCell = "GroupContactCell"
//      static let helperBannerCell = "HelperBannerCell"
      static let compressionCell = "CompressionSettingsCell"
      static let videoPreviewCell = "VideoPreviewCell"
      static let contentBannerCell = "ContentBannerCell"
      static let permissionCell = "PermissionCell"
      static let permissionBannerCell = "PermissionBannerCell"
      static let permissionContinueCell = "PermissionContinueCell"
      static let premiumFeature = "PremiumFeatureCell"
      static let currentSubscription = "CurrentSubscriptionCell"
      static let premiumFeaturesSubcription = "PremiumFeaturesSubscriptionCell"
      static let featuresSubscription = "FeaturesSubscriptionCell"
      static let contactInfo = "ContactInfoCell"
      static let contactThumbnail = "ContactThumbnailCell"
      static let actionCell = "ActionCell"
    }
    
    struct views {
      static let groupHeaderView = "GroupedAssetsReusableHeaderView"
      static let groupFooterView = "GroupedAssetsReusableFooterView"
      static let contactGroupHeader = "GroupedContactsHeaderView"
      static let bottomButtonBarView = "BottomButtonBarView"
      static let bottomDoubleButtonBarView = "BottomDoubleButtonBarView"
      static let searchBar = "SearchBarView"
      static let phassetAnnotation = "PHAssetAnnotationView"
      static let locationHeader = "LocationHeaderCollectionReusableView"
    }
    
    struct xibs {
      /// `cell xibs`
      static let mediaTypeCell = "MediaTypeCell"
      static let contentTypeCell = "ContentTypeCell"
      static let photoSimpleCell = "PhotoCell"
      static let photoPreviewCell = "PhotoPreviewCell"
      static let dropDownCell = "DropDownMenuCell"
      static let cleanInfoCell = "DeepCleanInfoCell"
      static let contactCell = "ContactCell"
      static let groupContactCell = "GroupContactCell"
//      static let bannerCell = "HelperBannerCell"
      static let compressionCell = "CompressionSettingsCell"
      static let videoPreivew = "VideoPreviewCell"
      static let contentBannerCell = "ContentBannerCell"
      static let permissionCell = "PermissionCell"
      static let permissionBannerCell = "PermissionBannerCell"
      static let permissionContinueCell = "PermissionContinueCell"
      static let premiumFeature = "PremiumFeatureCell"
      static let currentSubscription = "CurrentSubscriptionCell"
      static let premiumFeaturesSubcription = "PremiumFeaturesSubscriptionCell"
      static let featuresSubscription = "FeaturesSubscriptionCell"
      static let contactInfo = "ContactInfoCell"
      static let contactThumbnail = "ContactThumbnailCell"
      static let actionCell = "ActionCell"
      /// `views`
      static let groupHeader = "GroupedAssetsReusableHeaderView"
      static let groupFooter = "GroupedAssetsReusableFooterView"
      static let contactGroupHeader = "GroupedContactsHeaderView"
      static let bottomButtonBarView = "BottomButtonBarView"
      static let bottomDoubleButtonBarView = "BottomDoubleButtonBarView"
      static let searchBar = "SearchBarView"
      static let locationHeader = "LocationHeaderCollectionReusableView"
      
      static let carouselView = "CarouselItemView"
      static let datePickerContainer = "DateSelectebleView"
      
      /// `navigation`
      static let startingNavigationBar = "StartingNavigationBar"
      static let navigationBar = "NavigationBar"
      
      /// controllers
      static let location = "LocationGridController"
    }
    
    struct mapAnnotation {
      static let cluster = "ClusterAnnotation"
      static let pin = "PinAnnotation"
    }
    
    struct onboarding {
      static let photo = "com.cleaner.onboarding.photo"
      static let video = "com.cleaner.onboarding.video"
      static let contacts = "com.cleaner.onbarding.contacts"
    }
    
    struct segue {
      static let showLowerDatePicker = "ShowDatePickerLowerDateSelectorController"
      static let showUpperDatePicker = "ShowDatePickerUpperDateSelectorController"
      static let showExportContacts = "ShowExportContactsControllerSegue"
      static let showSizeSelector = "ShowVideoSizeSelectorSegue"
      static let showCustomCompression = "ShowCustomCompressionSegue"
      static let lifeTime = "ShowLifeTimeControllerSegue"
      static let backupContacts = "ShowContactsBackupControllerSegue"
      static let location = "ShowLocationInfoControllerSegue"
    }
  }
  
  struct folders {
    static let temp = "temp"
    static let contactsArchive = "ContactsArchhive"
    static let compressedVideo = "CompressedVideo"
  }
  
  struct uiElementsNames {
    struct layers {
      static let progressLayer = "progress"
    }
  }
  
  struct dateFormat {
    static let dmy = "dd-MM-yyy"
    static let dateFormat = "dd MMM, yyyy"
    static let fullDateFormat = "yyyy-MM-dd HH:mm:ss"
    static let expiredDateFormat = "dd\\MM\\yyyy"
    static let fullDmy = "dd-MM-yyyy HH:mm:ss"
    static let monthDateYear = "MMM d, yyyy"
    static let readableFormat = "dd MMMM yyyy"
  }
  
  struct defaultValues {
    static let dateNow = Date()
  }
  
  struct contacts {
    
    struct contactsContainer{
      static let card = "Card"
      static let iCloud = "iCloud"
      static let addressBook = "Address Book"
      static let google = "Google"
      static let contancts = "Contacts"
      static let yahoo = "Yahoo"
      static let facebook = "Facebook"
    }
  }
  
  struct video {}
}
