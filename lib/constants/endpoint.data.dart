// Auth
const endpointAuth = '/auth/';
const endpointRefreshToken = '/mobile/auth/refresh';
const endpointAuthQR = '/mobile/auth/login_qr';

// Trucks
const endpointTruckMobile = '/mobile/trucks/all';
const endpointTruckByPatent = '/mobile/trucks/patent';

// Operations
const endpointOperationMobile = '/mobile/operations/all';

// Clients
const endpointClientByOperationMobile = '/mobile/clients/byOperations';

// Services - Users
const endpointUserServiceInProcess = '/mobile/users/serviceInProcess';
const endpointQtyUserServiceInProcess = '/mobile/Users/qtyServiceInProcess';

// Locations
const endpointLocationOriginMobile = '/mobile/locations/GetOriginsLocations';
const endpointLocationDestinyMobile = '/mobile/locations/GetDestinyLocations';

// Document Types - Get All
const endpointDocumentTypes = '/mobile/documentType/all';

// New Services - Search Section
const endpointSection = '/mobile/sections/uniqueSection';

// New Services - Create Service
const endpointService = '/mobile/services/create';

// New Service - Show Service
const endpointServiceShow = '/mobile/services/serviceshow';

// Service - Update Service Line
const endpointServiceUpdateLine = '/mobile/ServiceLine/updateLine';

// Service - Get Service Line Dispatch Guide
const endpointServiceLineDispatchGuide =
    '/mobile/GuideNumber/getByServiceLineId';

// Service Line - Add Guide Number [TODO - Change Url for exclusive endpoint]
const endpointDocumentsDispatchGuide = '/documentfiles/documentDispatchGuide';

// Service - Start
const endpointServiceStart = '/mobile/services/startService';

// Service - Destiny Done
const endpointServiceDestinyDone = '/mobile/services/destinyDoneService';

// Service - Finish Service
const endpointServiceFinish = '/mobile/services/finishService';

// Service - Get Confirmed Service
const endpointServiceConfirmed = '/mobile/services/confirmedService';

// Dispatch Guide - Show Document
const endpointDispatchGuideShow = '/documentfiles/download/';

// Documents
const endpointDocuments = '/mobile/documents/getAllByServiceLineId';

// Documents - Upload
const endpointDocumentsUpload = '/mobile/documents/upload';
