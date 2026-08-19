report 50007 "Vehicle Inspection CheckList"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultRenderingLayout = Vehicle;

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
            column(CompanyInfo_Address;CompanyInfo.Address) { }
            column(CompanyInfo_Address2;CompanyInfo."Address 2") { }
            column(Inspection_Type; "Inspection Type") { }
            column(ReportTitle; ReportTitle) { }
            column(State; State) { }
            column(Hours;Hours) { }
            column(Technician;Technician) { }
            column(Service_Date;"Service Date") { }
            column(Technician_s_Name;"Technician's Name") { }
            column(Current_Hours;"Current Hours") { }
        
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
                column(WalkAround_Present; Present){ }


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
                column(UnderBonnet_Present; Present){ }


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
                column(InsideVehicle_Present; Present){ }

                trigger OnAfterGetRecord()
                begin
                    InsideVehicle_Status := false;
                    if InsideVehicle.Monday or InsideVehicle.Missing or InsideVehicle.Damaged or InsideVehicle.Present or InsideVehicle.Tuesday or InsideVehicle.Wednesday or InsideVehicle.Thursday or InsideVehicle.Friday or InsideVehicle.Saturday or InsideVehicle.Sunday then
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
                column(EmergencyEquipment_Present; Present){ }

                trigger OnAfterGetRecord()
                begin
                    EmergencyEquipment_Status := false;
                    if EmergencyEquipment.Monday or EmergencyEquipment.Missing or EmergencyEquipment.Damaged or EmergencyEquipment.Present or EmergencyEquipment.Tuesday or EmergencyEquipment.Wednesday or EmergencyEquipment.Thursday or EmergencyEquipment.Friday or EmergencyEquipment.Saturday or EmergencyEquipment.Sunday then
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
                column(BeforeSettingOff_Present; Present){ }

                trigger OnAfterGetRecord()
                begin
                    BeforeSettingOff_Status := false;
                    if BeforeSettingOff.Monday or BeforeSettingOff.Missing or BeforeSettingOff.Damaged or BeforeSettingOff.Present or BeforeSettingOff.Tuesday or BeforeSettingOff.Wednesday or BeforeSettingOff.Thursday or BeforeSettingOff.Friday or BeforeSettingOff.Saturday or BeforeSettingOff.Sunday then
                        BeforeSettingOff_Status := true;
                end;

                trigger OnPreDataItem()
                begin
                    BeforeSettingOff_Status := false;
                end;
            }

             dataitem(General; "Form Line")
            {
                DataItemLinkReference = "Form Header";
                DataItemLink = "Document Type" = FIELD("Document Type"),
                               "Document No." = FIELD("No.");
                DataItemTableView = where(Sections = filter("General"));

                column(General_Description; Description) { }
                column(General_Details; Details) { }
                column(General_Missing; Missing) { }
                column(General_Damaged; Damaged) { }
                column(General_Okay; Present) { }
                column(General_Fair; Fair) { }
                column(General_Comment; Comment) { }
                column(General_Status; General_Status) { }



                trigger OnAfterGetRecord()
                begin
                    General_Status := false;
                    if General.Monday or General.Present or General.Fair or General.Missing or General.Damaged or General.Tuesday or General.Wednesday or General.Thursday or General.Friday or General.Saturday or General.Sunday then
                       General_Status := true;
                    // General_Status := true;
                end;

                trigger OnPreDataItem()
                begin
                    General_Status := false;
                end;
            }

            dataitem(Engine; "Form Line")
            {
                DataItemLinkReference = "Form Header";
                DataItemLink = "Document Type" = FIELD("Document Type"),
                               "Document No." = FIELD("No.");
                DataItemTableView = where(Sections = filter("Engine"));

                column(Engine_Description; Description) { }
                column(Engine_Details; Details) { }
                column(Engine_Missing; Missing) { }
                column(Engine_Damaged; Damaged) { }
                column(Engine_Okay; Present) { }
                column(Engine_Fair; Fair) { }
                
                column(Engine_Comment; Comment) { }
                column(Engine_Status; Engine_Status) { }



                trigger OnAfterGetRecord()
                begin
                    Engine_Status := false;
                    if Engine.Monday or Engine.Present or Engine.Fair or Engine.Missing or Engine.Damaged or Engine.Tuesday or Engine.Wednesday or Engine.Thursday or Engine.Friday or Engine.Saturday or Engine.Sunday then
                       Engine_Status := true;
                    // General_Status := true;
                end;

                trigger OnPreDataItem()
                begin
                    Engine_Status := false;
                end;
            }

            dataitem(Fuel; "Form Line")
            {
                DataItemLinkReference = "Form Header";
                DataItemLink = "Document Type" = FIELD("Document Type"),
                               "Document No." = FIELD("No.");
                DataItemTableView = where(Sections = filter("Fuel"));

                column(Fuel_Description; Description) { }
                column(Fuel_Details; Details) { }
                column(Fuel_Missing; Missing) { }
                column(Fuel_Damaged; Damaged) { }
                column(Fuel_Okay; Present) { }
                column(Fuel_Fair; Fair) { }
                
                column(Fuel_Comment; Comment) { }
                column(Fuel_Status; Fuel_Status) { }



                trigger OnAfterGetRecord()
                begin
                    Fuel_Status := false;
                    if Fuel.Monday or Fuel.Present or Fuel.Fair or Fuel.Missing or Fuel.Damaged or Fuel.Tuesday or Fuel.Wednesday or Fuel.Thursday or Fuel.Friday or Fuel.Saturday or Fuel.Sunday then
                       Fuel_Status := true;
                    // Fuel_Status := true;
                end;

                trigger OnPreDataItem()
                begin
                    Fuel_Status := false;
                end;
            }

            dataitem(Electrical; "Form Line")
            {
                DataItemLinkReference = "Form Header";
                DataItemLink = "Document Type" = FIELD("Document Type"),
                               "Document No." = FIELD("No.");
                DataItemTableView = where(Sections = filter("Electrical"));

                column(Electrical_Description; Description) { }
                column(Electrical_Details; Details) { }
                column(Electrical_Missing; Missing) { }
                column(Electrical_Damaged; Damaged) { }
                column(Electrical_Okay; Present) { }
                column(Electrical_Fair; Fair) { }
                
                column(Electrical_Comment; Comment) { }
                column(Electrical_Status; Electrical_Status) { }



                trigger OnAfterGetRecord()
                begin
                    Electrical_Status := false;
                    if Electrical.Monday or Electrical.Present or Electrical.Fair or Electrical.Missing or Electrical.Damaged or Electrical.Tuesday or Electrical.Wednesday or Electrical.Thursday or Electrical.Friday or Electrical.Saturday or Electrical.Sunday then
                       Electrical_Status := true;
                    // Electrical_Status := true;
                end;

                trigger OnPreDataItem()
                begin
                    Electrical_Status := false;
                end;
            }

            dataitem(Lubrication; "Form Line")
            {
                DataItemLinkReference = "Form Header";
                DataItemLink = "Document Type" = FIELD("Document Type"),
                               "Document No." = FIELD("No.");
                DataItemTableView = where(Sections = filter("Lubrication"));

                column(Lubrication_Description; Description) { }
                column(Lubrication_Details; Details) { }
                column(Lubrication_Missing; Missing) { }
                column(Lubrication_Damaged; Damaged) { }
                column(Lubrication_Okay; Present) { }
                column(Lubrication_Fair; Fair) { }
                column(Lubrication_Comment; Comment) { }
                column(Lubrication_Status; Lubrication_Status) { }



                trigger OnAfterGetRecord()
                begin
                    Lubrication_Status := false;
                    if Lubrication.Monday or Lubrication.Present or Lubrication.Fair or Lubrication.Missing or Lubrication.Damaged or Lubrication.Tuesday or Lubrication.Wednesday or Lubrication.Thursday or Lubrication.Friday or Lubrication.Saturday or Lubrication.Sunday then
                       Lubrication_Status := true;
                    // Lubrication_Status := true;
                end;

                trigger OnPreDataItem()
                begin
                    Lubrication_Status := false;
                end;
            }

            dataitem(Mechanical; "Form Line")
            {
                DataItemLinkReference = "Form Header";
                DataItemLink = "Document Type" = FIELD("Document Type"),
                               "Document No." = FIELD("No.");
                DataItemTableView = where(Sections = filter("Mechanical"));

                column(Mechanical_Description; Description) { }
                column(Mechanical_Details; Details) { }
                column(Mechanical_Missing; Missing) { }
                column(Mechanical_Damaged; Damaged) { }
                column(Mechanical_Okay; Present) { }
                column(Mechanical_Fair; Fair) { }
                
                column(Mechanical_Comment; Comment) { }
                column(Mechanical_Status; Mechanical_Status) { }


                trigger OnAfterGetRecord()
                begin
                    Mechanical_Status := false;
                    if Mechanical.Monday or Mechanical.Present or Mechanical.Fair or Mechanical.Missing or Mechanical.Damaged or Mechanical.Tuesday or Mechanical.Wednesday or Mechanical.Thursday or Mechanical.Friday or Mechanical.Saturday or Mechanical.Sunday then
                       Mechanical_Status := true;
                    // Mechanical_Status := true;
                end;

                trigger OnPreDataItem()
                begin
                    Mechanical_Status := false;
                end;
            }

            dataitem(Housekeeping; "Form Line")
            {
                DataItemLinkReference = "Form Header";
                DataItemLink = "Document Type" = FIELD("Document Type"),
                               "Document No." = FIELD("No.");
                DataItemTableView = where(Sections = filter("Housekeeping"));

                column(Housekeeping_Description; Description) { }
                column(Housekeeping_Details; Details) { }
                column(Housekeeping_Missing; Missing) { }
                column(Housekeeping_Damaged; Damaged) { }
                column(Housekeeping_Okay; Present) { }


                column(Housekeeping_Fair;Fair) {}
                
                column(Housekeeping_Comment; Comment) { }
                column(Housekeeping_Status; Housekeeping_Status) { }


                trigger OnAfterGetRecord()
                begin
                    Housekeeping_Status := false;
                    if Housekeeping.Monday or Housekeeping.Present or Housekeeping.Fair or Housekeeping.Missing or Housekeeping.Damaged or Housekeeping.Tuesday or Housekeeping.Wednesday or Housekeeping.Thursday or Housekeeping.Friday or Housekeeping.Saturday or Housekeeping.Sunday then
                       Housekeeping_Status := true;
                    // Housekeeping_Status := true;
                end;

                trigger OnPreDataItem()
                begin
                    Housekeeping_Status := false;
                end;
            }

            dataitem("Fixed Asset"; "Fixed Asset")
            {
                DataItemLinkReference = "Form Header";
                DataItemLink = "No." = FIELD("Equipment No.");
                    //"Document No." = FIELD("No.");
                //DataItemTableView = where("Equipment Status" = filter("Available"));

                //column(Service_Date;"Service Date") { }
                


            }

            trigger OnAfterGetRecord()
            begin
                if "Form Header"."Inspection Type" = "Form Header"."Inspection Type"::"Pre-Trip" then
                    ReportTitle := 'PRE-TRIP VEHICLE INSPECTION CHECKLIST'
                else if "Form Header"."Inspection Type" = "Form Header"."Inspection Type"::"Post-Trip" then
                    ReportTitle := 'POST-TRIP VEHICLE INSPECTION CHECKLIST';
                //else if "Form Header"."Equipment Type" = 'VEHICLES' then ReportTitle := 'GENERATOR INSPECTION CHECKLIST';
            end;
        }
    }

    rendering
    {
        layout(Vehicle)
        {
            Type = RDLC;
            LayoutFile = 'vehicleInspectionChecklist.rdl';
        }
        layout(Generator)
        {
            Type = RDLC;
            LayoutFile = 'GeneratorChecklist.rdl';
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
        General_Status: Boolean;
        Engine_Status : Boolean;
        Fuel_Status : Boolean;
        Electrical_Status : Boolean;
        Lubrication_Status : Boolean;
        Mechanical_Status : Boolean;
        Housekeeping_Status : Boolean;

    trigger OnPreReport()
    var
        myInt: Integer;
       
    begin
        CompanyInfo.Get();
        CompanyInfo.CalcFields(Picture);
        
    end;
}