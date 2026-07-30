
report 50014 "Routine Maintenance"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    //DefaultRenderingLayout = rdlLayout;
    //DefaultLayout= word;
     DefaultLayout= RDLC;
     RDLCLayout = 'RM2.rdl';
     //WordLayout = 'RoutineMaintenanceTracker.docx';

    dataset
    {
        dataitem("Fixed Asset"; "Fixed Asset")
        {
            //DataItemTableView = where("Document Type" = const("Routine Service Tracker"));
            RequestFilterFields= "No.", "Equipment Type", "FA Location Code";
            column(CompanyInfo_Name; CompanyInfo.Name) { }
            column(CompanyInfo_Address; CompanyInfo.Address) { }
            column(CompanyImage; CompanyInfo.Picture) { }
            column(No;"No.") { }
            
            column(Vehicle_No;"No."){ }
            column(Vehicle_Name; "Description") { }
            
            column(Vehicle_RegNo; "Registration No.") { }
            column(Vehicle_Type; "Equipment Type") { }
            column(Service_Interval;"Service Interval"){}
            column(Service_Date;"Service Date"){}
            column(Vehicle_Equipment_Location;"FA Location Code"){}
           
            
            column(Next_Service_Date;"Next Service Date"){}
            column(Next_Service_KM;"Next Service At Mileage"){}
            //column(Next_Service_Hours;"Next Service Hours"){}
            column(Current_Mileage;"Vehicle Mileage"){}
           // column("Date_current_mileage"; Today()){}
            column("Remaining_mileage_to_service"; RemainderMileage){}
            column(Service_Interval_Hours;"Service Interval Hours"){}
            column(Current_Hours;"Current Hours"){}
            column(Next_Service_Hours;"Next Service Hours"){}
            column(Hours_to_Next_Service;"Hours to Next Service"){}
            column(FA_Location_Code;"FA Location Code"){ }
            column(Equipment_Status;"Equipment Status"){ }
            column(Gen_Set_Capacity;"Gen Set Capacity"){ }
            column(Gen_Set_S_No;"Gen Set S/No"){ }
            column(Engine_Model;"Engine Model"){ }

            column("User_id"; User){ }

            trigger OnAfterGetRecord()
            var 
            begin
                RemainderMileage := "Next Service At Mileage" - "Vehicle Mileage";
                
            end;

            trigger OnPreDataItem()
            begin
               if EquipmentNoFilter <> '' then
                   "Fixed Asset".SetRange("No.", EquipmentNoFilter);
                
            end;
        }
        
    }
    

    // rendering
    // {
    //     layout(rdlLayout)
    //     {
    //         Type = RDLC;
    //         LayoutFile = 'RoutineMaintenanceTracker.rdl';

           
    //     }
    //     layout(wordLayout)
    //     {
    //         Type = Word;
    //         LayoutFile = 'RoutineMaintenanceTracker.docx';

            
    //     }
    // }

    requestpage
    {
        layout
        {
            area(Content)
            {
                group(Group)
                {
                    Caption = 'Report Filters';
                    field(EquipmentNoFilter; EquipmentNoFilter)
                    {
                        ApplicationArea = All;
                        Caption = 'Equipment No.';
                        TableRelation = "Fixed Asset"."No.";
                    }
 

                }
            }
        }
        
    }

    trigger OnPreReport()
     
      
    begin
        CompanyInfo.Get();
        CompanyInfo.CalcFields(Picture);
        User := UserId();
        if EquipmentNoFilter <> '' then
        "Fixed Asset".SetRange("No.", EquipmentNoFilter);
                
    end;

    var
        CompanyInfo: Record "Company Information";
        ApproverName: Text;

        Remaining: Decimal;
        EquipmentNoFilter: Code[20];

        LocationFilter: Code[20];

        RemainderMileage: Integer;

        User: Text[100];

        
}