
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
        dataitem("Form Line"; "Form Line")
        {
            DataItemTableView = where("Document Type" = const("Routine Service Tracker"));
            RequestFilterFields= "Equipment No.","Equipment Type", "Vehicle/Equipment Location";
            column(CompanyInfo_Name; CompanyInfo.Name) { }
            column(CompanyInfo_Address; CompanyInfo.Address) { }
            column(CompanyImage; CompanyInfo.Picture) { }
            column(Document_No;"Document No.") { }
            
            column(Vehicle_No;"Equipment No."){ }
            column(Vehicle_Name; "Equipment Name") { }
            
            column(Vehicle_RegNo; "Equipment RegNo") { }
            column(Vehicle_Type; "Equipment Type") { }
            column(Service_Interval;"Service Interval"){}
            column(Service_Date;"Service Date"){}
            column(Vehicle_Equipment_Location;"Vehicle/Equipment Location"){}
            column(Service_KM;"Service KM"){}
            column(Service_Hours;"Service Hours"){}
            column(Details_Of_Service_Done;"Details Of Service Done"){}
            column(Next_Service_Date;"Next Service Date"){}
            column(Next_Service_KM;"Next Service KM"){}
            column(Next_Service_Hours;"Next Service Hours"){}
            column(Current_Mileage;"Current Mileage"){}
            column("Date_current_mileage";"Date of Current Mileage"){}
            column("Remaining_mileage_to_service";"Remaining Service Mileage"){}
        }
        dataitem("Form Header"; "Form Header")
        {
            DataItemTableView = where("Document Type" = const("Routine Service Tracker"));
            // DataItemLink = 
            //         "Document No." = FIELD("Document No.");

            column("PreparedBy"; "Prepared by"){}
           
            //column("Date_current_mileage";"Last Vehicle Inspection"){}
            

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

        if EquipmentNoFilter <> '' then
        "Form Header".SetRange("Equipment No.", EquipmentNoFilter);
        
        
    end;

    var
        CompanyInfo: Record "Company Information";
        ApproverName: Text;

        Remaining: Decimal;
        EquipmentNoFilter: Code[20];

        LocationFilter: Code[20];

        
}