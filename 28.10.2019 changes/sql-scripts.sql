
-- TECH
select type, message, payload,class_name from log where type =0;
select COUNT(*), class_name from LOG where type =2 group by class_name;

select type, log_level, message, payload,class_name, logger_info from log where type =0 and class_name='com.fodb.service.archive.service.ExternalArchiveService';


-- GDPR
select type, message, payload,class_name from log where type =1;
select COUNT(*), class_name from LOG where type =1 group by class_name;

select type, log_level, message, payload,class_name, logger_info from log where type =1 and class_name='com.fodb.service.transaction.validator.WithdrawalValidator';

-- externalArchiveService, tranapi_archive_external.postman
select type, log_level, message, payload,class_name, logger_info from log where type =1 and class_name='com.fodb.service.archive.mock.MockArchiveEndpoint';
select type, log_level, message, payload,class_name, logger_info from log where type =1 and class_name='com.fodb.service.archive.d3.soapclient.AbstractArchiveSoapClient';


------- Business
select type, message, payload,class_name from log where type =2;
select COUNT(*), class_name from LOG where type =2 group by class_name;

-- tranapi_ISIN_Validierung.postman
select type, log_level, message, payload,class_name, logger_info from log where type =2 and class_name='com.fodb.service.transaction.validator.WithdrawalValidator';
select type, log_level, message, payload,class_name, logger_info from log where type =2 and class_name='com.fodb.service.transaction.validator.InvestmentValidator';

-- tranapi_archive_external.postman
select type, log_level, message, payload,class_name, logger_info from log where type =2 and class_name='com.fodb.service.archive.validator.ArchiveProcessValidator';
select type, log_level, message, payload,class_name, logger_info from log where type =2 and class_name='com.fodb.service.archive.exception.handler.ExceptionController';

-- to remove all entries.
delete from log;