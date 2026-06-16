report 50013 "Update Driver License"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    ProcessingOnly = true;
    dataset
    {
        dataitem(Employee; Employee)
        {
            trigger OnPreDataItem()
            begin
                Employee.SetFilter("License Validity End date", '<>%1', 0D);
            end;

            trigger OnAfterGetRecord()
            var
                LicenseDays: Integer;
                MedicalFitnessDays: Integer;
                DefensiveDrivingDays: Integer;
                Employee1: Record Employee;
                FleetManagementSetup: Record "Fleet Management Setup";
                EmailSubject: Text[250];
                EmailBody: Text[1000];
            begin
                LicenseDays := 0;
                MedicalFitnessDays := 0;
                DefensiveDrivingDays := 0;
                EmailBody := '';
                EmailSubject := '';

                LicenseDays := Employee."License Validity End date" - Today();

                if Employee."Fitness Validity End Date" <> 0D then
                    MedicalFitnessDays := Employee."Fitness Validity End Date" - Today();

                if Employee."DefensiveDrive ValidEndDate" <> 0D then
                    DefensiveDrivingDays := Employee."DefensiveDrive ValidEndDate" - Today();

                if Employee1.Get(Employee."No.") then begin
                    Employee1.Validate("Days to License expiry", LicenseDays);
                    Employee1.Validate("Medical Fitness Days", MedicalFitnessDays);
                    Employee1.Validate("Defensive Driving Days", DefensiveDrivingDays);
                    Employee1.Modify();
                end;

                // Send Email Notification
                FleetManagementSetup.Get();
                if not FleetManagementSetup."Send Expiry Notification" then
                    exit;

                if FleetManagementSetup."Expiry Warning" = 0 then
                    exit;

                if (LicenseDays > 0) and (LicenseDays <= FleetManagementSetup."Expiry Warning") then begin
                    EmailSubject := 'Driver License Expiry Notification';
                    EmailBody := 'Dear ' + Employee.FullName() + ',' + '\n\n' +
                                 'This is to inform you that your Driver License is set to expire on ' +
                                 Format(Employee."License Validity End date") + ', which is in ' +
                                 Format(LicenseDays) + ' days.' + '\n\n' +
                                 'Please take the necessary steps to renew your license before the expiry date.' + '\n\n' +
                                 'Best regards,' + '\n' +
                                 'Fleet Management Team';
                    SendReleaseEmail(Employee, EmailSubject, EmailBody);
                end;

                if (MedicalFitnessDays > 0) and (MedicalFitnessDays <= FleetManagementSetup."Expiry Warning") then begin
                    EmailSubject := 'Medical Fitness Expiry Notification';
                    EmailBody := 'Dear ' + Employee.FullName() + ',' + '\n\n' +
                                 'This is to inform you that your Medical Fitness certificate is set to expire on ' +
                                 Format(Employee."Fitness Validity End Date") + ', which is in ' +
                                 Format(MedicalFitnessDays) + ' days.' + '\n\n' +
                                 'Please take the necessary steps to renew your certificate before the expiry date.' + '\n\n' +
                                 'Best regards,' + '\n' +
                                 'Fleet Management Team';
                    SendReleaseEmail(Employee, EmailSubject, EmailBody);
                end;

                if (DefensiveDrivingDays > 0) and (DefensiveDrivingDays <= FleetManagementSetup."Expiry Warning") then begin
                    EmailSubject := 'Defensive Driving Certificate Expiry Notification';
                    EmailBody := 'Dear ' + Employee.FullName() + ',' + '\n\n' +
                                 'This is to inform you that your Defensive Driving certificate is set to expire on ' +
                                 Format(Employee."DefensiveDrive ValidEndDate") + ', which is in ' +
                                 Format(DefensiveDrivingDays) + ' days.' + '\n\n' +
                                 'Please take the necessary steps to renew your certificate before the expiry date.' + '\n\n' +
                                 'Best regards,' + '\n' +
                                 'Fleet Management Team';
                    SendReleaseEmail(Employee, EmailSubject, EmailBody);
                end;
            end;
        }
    }

    procedure SendReleaseEmail(Employee: Record Employee; SubjectEmail: Text[250]; BodyEmail: Text[1000])
    var
        EmailBody: Text[1000];
        MSTRecipientsList: List of [Text];
        MSTCCRecipientsList: List of [Text];
        MSTBCCRecepientsList: List of [Text];
        FileMgt: Codeunit "File Management";
        EmailObj: Codeunit Email;
        EmailMsg: Codeunit "Email Message";
        RequisitionStatus: Text[50];
        FleetManagementSetup: Record "Fleet Management Setup";
        DocumentNo: Code[20];
        EmailSubject: Text[250];
    begin
        if FleetManagementSetup."Send Expiry Notification" then begin
            if (Employee."E-Mail" = '') AND (Employee."Company E-Mail" = '') then
                exit;

            EmailBody := BodyEmail;
            MSTRecipientsList.Add(Employee."E-Mail");
            MSTRecipientsList.Add(Employee."Company E-Mail");
            DocumentNo := Employee."No.";
            EmailSubject := SubjectEmail + ' - ' + DocumentNo;
            EmailMsg.Create(MSTRecipientsList, EmailSubject,
            EmailBody,
            true, MSTCCRecipientsList, MSTBCCRecepientsList);
            EmailObj.Send(EmailMsg, Enum::"Email Scenario"::Default);
        end;
    end;
}