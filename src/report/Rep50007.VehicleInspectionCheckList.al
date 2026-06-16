report 50007 "Vehicle Inspection CheckList"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultRenderingLayout = LayoutName;

    dataset
    {
        dataitem("Form Header"; "Form Header")
        {
            DataItemTableView = where("Document Type" = filter("Equipment Inspection"));
            column(No_; "No.") { }
            column(Driver_No_; "Driver No.") { }
            column(Driver_Name; "Driver Name") { }
            column(Week_Start_Km_s; "Week Start Km's") { }
            column(Week_End_Km_s; "Week End Km's") { }
            column(Week_Start_Date; "Week Start Date") { }
            column(Department; Department) { }
            column(Crew_Location; "Crew Location") { }
            column(Equipment_No_; "Equipment No.") { }
            column(Equipment_RegNo; "Equipment RegNo") { }
            column(Equipment_Make; "Equipment Make") { }
            column(Equipment_Name; "Equipment Name") { }
            column(Defensive_Driving_Exp__Date; "Defensive Driving Exp. Date") { }
            column(License_Expiry_Date; "License Expiry Date") { }
            column("Party_Exp__Date"; "3RD Party Exp. Date") { }
            column(Next_Service_at_Mileage; "Next Service at Mileage") { }
            column(CompanyInfo_Name; CompanyInfo.Name) { }
            column(CompanyInfo_Picture; CompanyInfo.Picture) { }
            column(Inspection_Type; "Inspection Type") { }
            column(ReportTitle; ReportTitle) { }
            column(State; State) { }

            dataitem(WalkAround; "Form Line")
            {
                DataItemLinkReference = "Form Header";
                DataItemLink = "Document Type" = FIELD("Document Type"),
                               "Document No." = FIELD("No.");
                DataItemTableView = where(Sections = filter("Walk Around"));

                column(WalkAround_Description; Description) { }
                column(WalkAround_Details; Details) { }
                column(WalkAround_Monday; Monday) { }
                column(WalkAround_Tuesday; Tuesday) { }
                column(WalkAround_Wednesday; Wednesday) { }
                column(WalkAround_Thursday; Thursday) { }
                column(WalkAround_Friday; Friday) { }
                column(WalkAround_Saturday; Saturday) { }
                column(WalkAround_Sunday; Sunday) { }
                column(WalkAround_Comment; Comment) { }
                column(WalkAround_Status; WalkAround_Status) { }
                column(WalkAround_Missing; Missing) { }
                column(WalkAround_Damaged; Damaged) { }

            

                trigger OnAfterGetRecord()
                begin
                    WalkAround_Status := false;
                    if WalkAround.Monday or WalkAround.Missing or WalkAround.Damaged or WalkAround.Tuesday or WalkAround.Wednesday or WalkAround.Thursday or WalkAround.Friday or WalkAround.Saturday or WalkAround.Sunday then
                        WalkAround_Status := true;
                    // WalkAround_Status := true;
                end;

                trigger OnPreDataItem()
                begin
                    WalkAround_Status := false;
                end;
            }

            dataitem(UnderBonnet; "Form Line")
            {
                DataItemLinkReference = "Form Header";
                DataItemLink = "Document Type" = FIELD("Document Type"),
                               "Document No." = FIELD("No.");
                DataItemTableView = where(Sections = filter("Under Bonnet"));

                column(UnderBonnet_Description; Description) { }
                column(UnderBonnet_Details; Details) { }
                column(UnderBonnet_Monday; Monday) { }
                column(UnderBonnet_Tuesday; Tuesday) { }
                column(UnderBonnet_Wednesday; Wednesday) { }
                column(UnderBonnet_Thursday; Thursday) { }
                column(UnderBonnet_Friday; Friday) { }
                column(UnderBonnet_Saturday; Saturday) { }
                column(UnderBonnet_Sunday; Sunday) { }
                column(UnderBonnet_Comment; Comment) { }
                column(UnderBonnet_Status; UnderBonnet_Status) { }
                column(UnderBonnet_Missing; Missing) { }
                column(UnderBonnet_Damaged; Damaged) { }

                trigger OnAfterGetRecord()
                begin
                    UnderBonnet_Status := false;
                    if UnderBonnet.Monday or UnderBonnet.Missing or UnderBonnet.Damaged or UnderBonnet.Tuesday or UnderBonnet.Wednesday or UnderBonnet.Thursday or UnderBonnet.Friday or UnderBonnet.Saturday or UnderBonnet.Sunday then
                        UnderBonnet_Status := true;
                end;

                trigger OnPreDataItem()
                begin
                    UnderBonnet_Status := false;
                end;
            }

            dataitem(InsideVehicle; "Form Line")
            {
                DataItemLinkReference = "Form Header";
                DataItemLink = "Document Type" = FIELD("Document Type"),
                               "Document No." = FIELD("No.");
                DataItemTableView = where(Sections = filter("Inside Vehicle"));

                column(InsideVehicle_Description; Description) { }
                column(InsideVehicle_Details; Details) { }
                column(InsideVehicle_Monday; Monday) { }
                column(InsideVehicle_Tuesday; Tuesday) { }
                column(InsideVehicle_Wednesday; Wednesday) { }
                column(InsideVehicle_Thursday; Thursday) { }
                column(InsideVehicle_Friday; Friday) { }
                column(InsideVehicle_Saturday; Saturday) { }
                column(InsideVehicle_Sunday; Sunday) { }
                column(InsideVehicle_Comment; Comment) { }
                column(InsideVehicle_Status; InsideVehicle_Status) { }
                column(InsideVehicle_Missing; Missing) { }
                column(InsideVehicle_Damaged; Damaged) { }

                trigger OnAfterGetRecord()
                begin
                    InsideVehicle_Status := false;
                    if InsideVehicle.Monday or InsideVehicle.Missing or InsideVehicle.Damaged or InsideVehicle.Tuesday or InsideVehicle.Wednesday or InsideVehicle.Thursday or InsideVehicle.Friday or InsideVehicle.Saturday or InsideVehicle.Sunday then
                        InsideVehicle_Status := true;
                end;

                trigger OnPreDataItem()
                begin
                    InsideVehicle_Status := false;
                end;
            }

            dataitem(EmergencyEquipment; "Form Line")
            {
                DataItemLinkReference = "Form Header";
                DataItemLink = "Document Type" = FIELD("Document Type"),
                               "Document No." = FIELD("No.");
                DataItemTableView = where(Sections = filter("Emergency Equipment"));

                column(EmergencyEquipment_Description; Description) { }
                column(EmergencyEquipment_Details; Details) { }
                column(EmergencyEquipment_Monday; Monday) { }
                column(EmergencyEquipment_Tuesday; Tuesday) { }
                column(EmergencyEquipment_Wednesday; Wednesday) { }
                column(EmergencyEquipment_Thursday; Thursday) { }
                column(EmergencyEquipment_Friday; Friday) { }
                column(EmergencyEquipment_Saturday; Saturday) { }
                column(EmergencyEquipment_Sunday; Sunday) { }
                column(EmergencyEquipment_Comment; Comment) { }
                column(EmergencyEquipment_Status; EmergencyEquipment_Status) { }
                column(EmergencyEquipment_Missing; Missing) { }
                column(EmergencyEquipment_Damaged; Damaged) { }

                trigger OnAfterGetRecord()
                begin
                    EmergencyEquipment_Status := false;
                    if EmergencyEquipment.Monday or EmergencyEquipment.Missing or EmergencyEquipment.Damaged or EmergencyEquipment.Tuesday or EmergencyEquipment.Wednesday or EmergencyEquipment.Thursday or EmergencyEquipment.Friday or EmergencyEquipment.Saturday or EmergencyEquipment.Sunday then
                        EmergencyEquipment_Status := true;
                end;

                trigger OnPreDataItem()
                begin
                    EmergencyEquipment_Status := false;
                end;
            }
            dataitem(BeforeSettingOff; "Form Line")
            {
                DataItemLinkReference = "Form Header";
                DataItemLink = "Document Type" = FIELD("Document Type"),
                               "Document No." = FIELD("No.");
                DataItemTableView = where(Sections = filter("Before setting off"));

                column(BeforeSettingOff_Description; Description) { }
                column(BeforeSettingOff_Details; Details) { }
                column(BeforeSettingOff_Monday; Monday) { }
                column(BeforeSettingOff_Tuesday; Tuesday) { }
                column(BeforeSettingOff_Wednesday; Wednesday) { }
                column(BeforeSettingOff_Thursday; Thursday) { }
                column(BeforeSettingOff_Friday; Friday) { }
                column(BeforeSettingOff_Saturday; Saturday) { }
                column(BeforeSettingOff_Sunday; Sunday) { }
                column(BeforeSettingOff_Comment; Comment) { }
                column(BeforeSettingOff_Status; BeforeSettingOff_Status) { }
                column(BeforeSettingOff_Missing; Missing) { }
                column(BeforeSettingOff_Damaged; Damaged) { }

                trigger OnAfterGetRecord()
                begin
                    BeforeSettingOff_Status := false;
                    if BeforeSettingOff.Monday or BeforeSettingOff.Missing or BeforeSettingOff.Damaged or BeforeSettingOff.Tuesday or BeforeSettingOff.Wednesday or BeforeSettingOff.Thursday or BeforeSettingOff.Friday or BeforeSettingOff.Saturday or BeforeSettingOff.Sunday then
                        BeforeSettingOff_Status := true;
                end;

                trigger OnPreDataItem()
                begin
                    BeforeSettingOff_Status := false;
                end;
            }

            trigger OnAfterGetRecord()
            begin
                if "Form Header"."Inspection Type" = "Form Header"."Inspection Type"::"Pre-Trip" then
                    ReportTitle := 'PRE-TRIP VEHICLE INSPECTION CHECKLIST'
                else if "Form Header"."Inspection Type" = "Form Header"."Inspection Type"::"Post-Trip" then
                    ReportTitle := 'POST-TRIP VEHICLE INSPECTION CHECKLIST';
            end;
        }
    }

    rendering
    {
        layout(LayoutName)
        {
            Type = RDLC;
            LayoutFile = 'vehicleInspectionChecklist.rdl';
        }
    }

    var
        CompanyInfo: Record "Company Information";
        ReportTitle: Text[100];
        WalkAround_Status: Boolean;
        UnderBonnet_Status: Boolean;
        InsideVehicle_Status: Boolean;
        EmergencyEquipment_Status: Boolean;
        BeforeSettingOff_Status: Boolean;

    trigger OnPreReport()
    var
        myInt: Integer;
    begin
        CompanyInfo.Get();
        CompanyInfo.CalcFields(Picture);
    end;
}