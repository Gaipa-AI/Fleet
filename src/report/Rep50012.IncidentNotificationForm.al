report 50012 "Incident Notification Form"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultRenderingLayout = LayoutName;

    dataset
    {
        dataitem("Form Header"; "Form Header")
        {
            DataItemTableView = where("Document Type" = const("Incident Notification Form"));
            column(No_; "No.") { }
            column(Date; Date) { }
            column(CompanyInfo_Name; CompanyInfo.Name) { }
            column(CompanyInfo_Picture; CompanyInfo.Picture) { }
            column(Near_Miss; "Near Miss") { }
            column(First_Aid_Case_; "First Aid Case;") { }
            column(Medical_Treatment_Case_; "Medical Treatment Case;") { }
            column(Restricted_Work_Case_Injury_; "Restricted Work Case/Injury;") { }
            column(Lost_Time_Injury; "Lost Time Injury") { }
            column(Fatality; Fatality) { }
            column(Motor_Vehicle_Crash; "Motor Vehicle Crash") { }
            column(Property_Damage_Material_Loss; "Property Damage/Material Loss") { }
            column(Environmental_Spill; "Environmental Spill") { }
            column(Fire; Fire) { }
            column(Security_Incident; "Security Incident") { }
            column(Vector_Vermin_Infestation; "Vector/Vermin Infestation") { }
            column(Serious_Illness; "Serious Illness") { }
            column(Disease_Outbreak; "Disease Outbreak") { }
            column(Other; Other) { }
            column(Site_Specific_Location; "Site Specific Location") { }
            column(Title_of_Incident; "Title of Incident") { }
            column(Date_and_Time_of_Incident; "Date and Time of Incident") { }
            column(Reported_Date_and_Time; "Reported Date and Time") { }
            column(Description; Description) { }
            column(Parties_Involved; "Parties Involved") { }
            column(Client_Name; "Client Name") { }
            column(Was_anyone_injured_; "Was anyone injured?") { }
            column(AnyOne_Injured_Description; "AnyOne Injured Description") { }
            column(Was_there_any_property_damage_; "Was there any property damage?") { }
            column(Property_Damaged_Description; "Property Damaged Description") { }
            column(WasThereAnyEnvironmentalDamage; WasThereAnyEnvironmentalDamage) { }
            column(Environment_Damage_Description; "Environment Damage Description") { }
            column(What_is_the_incident_severity_; "What is the incident severity?") { }
            column(Severity_Description; "Severity Description") { }
            column(IncidentInvestigationRequired; IncidentInvestigationRequired) { }
            column(Investigation_Description; "Investigation Description") { }
            column(Designation; Designation) { }
            column(First_Name; "First Name") { }
            column(Last_Name; "Last Name") { }
            column(Shift_Duration; "Shift Duration") { }
            column(Contact; Contact) { }
            column(Residential_Address; "Residential Address") { }
            column(Supervisor_Name; "Supervisor Name") { }
            column(RelationshipToTheCompany; RelationshipToTheCompany) { }
            column(Description_Of_Injury_Illness; "Description Of Injury/Illness") { }
            column(Body_Location; "Body Location") { }
            column(Treatment_Given; "Treatment Given") { }
            column(Referral; Referral) { }
            column(Image; Image) { }
            column(Notifier_Name; "Notifier Name") { }
            column(Notifier_Title; "Notifier Title") { }
            column(Notifier_Work_Location; "Notifier Work Location") { }
            column(Notifier_Site_Manager; "Notifier Site Manager") { }
            column(Notifier_Contact; "Notifier Contact") { }
            column(Notifier_Email; "Notifier Email") { }

            dataitem(Correctives; "Incident Line")
            {
                DataItemLinkReference = "Form Header";
                DataItemTableView = where(Type = const(Corrective), "Document Type" = const("Incident Notification Form"));
                DataItemLink = "Document No." = FIELD("No.");
                column(CorrectiveCount; CorrectiveCount) { }
                column(Corrective_Description; Description) { }
                column(Corrective_status; Status) { }
                column(Corrective_Remarks; Remarks) { }

                trigger OnAfterGetRecord()
                begin
                    CorrectiveCount := CorrectiveCount + 1;
                end;
            }

            dataitem(Recommendation; "Incident Line")
            {
                DataItemLinkReference = "Form Header";
                DataItemTableView = where(Type = const(Recommendation), "Document Type" = const("Incident Notification Form"));
                DataItemLink = "Document No." = FIELD("No.");
                column(RecommendationInteger; RecommendationInteger) { }
                column(Recommendation_Description; Recommendation.Description) { }
                column(Responsible_Party; Recommendation."Responsible Party") { }

                trigger OnAfterGetRecord()
                begin
                    RecommendationInteger := RecommendationInteger + 1;
                end;
            }
        }
    }

    rendering
    {
        layout(LayoutName)
        {
            Type = RDLC;
            LayoutFile = 'IncidentNotification.rdl';
        }
    }

    trigger OnPreReport()
    begin
        CompanyInfo.Get();
        CompanyInfo.CalcFields(Picture);
        CorrectiveCount := 0;
        RecommendationInteger := 0;
    end;

    var
        CompanyInfo: Record "Company Information";
        CorrectiveCount: Integer;
        RecommendationInteger: Integer;
}