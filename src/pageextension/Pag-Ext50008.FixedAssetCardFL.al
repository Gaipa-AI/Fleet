pageextension 50008 "Fixed Asset Card FL" extends "Fixed Asset Card"
{
    layout
    {
        addafter(General)
        {
            group(fleetDetails)
            {
                Caption = 'Fleet Details';
                field("Equipment Status"; Rec."Equipment Status")
                {
                    ApplicationArea = All;
                    ToolTip = 'Indicates the current status of the equipment.';
                }
                field("Equipment Type"; Rec."Equipment Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Type of the equipment.';
                }
                field(Make; Rec.Make)
                {
                    ApplicationArea = All;
                    ToolTip = 'Make of the equipment.';
                }
                field(Model; Rec.Model)
                {
                    ApplicationArea = All;
                    ToolTip = 'Model of the equipment.';
                }
                field("Registration No."; Rec."Registration No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Registration number of the equipment.';
                }
                field("Work Condition"; ConditionOfWork)
                {
                    ApplicationArea = All;
                    Editable = false;
                    trigger OnDrillDown()
                    var
                        myInt: Integer;
                    begin
                        DrillDownActionOnPage();
                    end;
                }
                field("Vehicle Mileage"; Rec."Vehicle Mileage")
                {
                    ApplicationArea = All;
                    ToolTip = 'Current mileage of the vehicle in kilometers.';
                }
                field("Next Service At Mileage"; Rec."Next Service At Mileage")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Next Service At Mileage field (km).', Comment = '%';
                }
                field("3RD Party Expiry Date"; Rec."3RD Party Expiry Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the 3RD Party Expiry Date field.', Comment = '%';
                }
                field("Service Interval"; Rec."Service Interval")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Service Interval field (km).', Comment = '%';
                }
                field("Serviced"; Rec."Serviced")
                {
                    ApplicationArea = All;
                    ToolTip = 'Indicates whether the vehicle has been serviced.';
                    Editable = false;
                }
                field("Service Date"; Rec."Service Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Indicates on what date the vehicle was serviced.';
                    Editable = false;
                }
            }
        }
    }

    actions
    {
        // Add changes to page actions here
        addafter("C&opy Fixed Asset")
        {
            action(PutOutOfOperation)
            {
                ApplicationArea = All;
                Caption = 'Put Out of Operation';
                Image = StepOut;
                Promoted = true;
                PromotedCategory = Process;
                ToolTip = 'Put the equipment out of operation.';
                trigger OnAction()
                var
                    FixedAsset: Record "Fixed Asset";
                begin
                    if Confirm('Do you want to put this equipment out of operation?', true) then begin
                        if FixedAsset.Get(Rec."No.") then begin
                            if FixedAsset."Equipment Status" in [FixedAsset."Equipment Status"::"In Use", FixedAsset."Equipment Status"::"At Workshop"] then
                                Error('Equipment can only be put out of operation if it is currently not in use or at workshop. Please check the status.');

                            FixedAsset.PutEquipmentOutOfOperation();
                            Message('Equipment has been put out of operation.');
                        end else
                            Error('Fixed Asset not found.');
                    end;
                end;
            }
            action(WorkCondition)
            {
                ApplicationArea = All;
                Caption = 'Work Condition';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = WorkCenterLoad;
                ToolTip = 'View or edit the work condition of the equipment.';
                RunObject = page "Equipment Work Condition";
                RunPageLink = "Equipment No." = field("No."), Type = filter("Work Condition");
            }
            action("Maintenance Request")
            {
                ApplicationArea = All;
                Caption = 'Maintenance Request';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = List;
                ToolTip = 'Create a maintenance request for the equipment.';
                RunObject = page "All Maintenance Requests";
                RunPageLink = "Equipment No." = field("No.");
            }
            action(WorkOrder)
            {
                ApplicationArea = All;
                Caption = 'Maintenance Jobs';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = LogSetup;
                RunObject = page "Maintenance Job Cards";
                RunPageLink = "Equipment No." = field("No.");
            }
            action(MakeAvailable)
            {
                ApplicationArea = All;
                Caption = 'Make Available';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = AvailableToPromise;

                trigger OnAction()
                var
                    myInt: Integer;
                begin
                    if Confirm('Are you sure you want to make this Equipment Available?', true) then
                        MakeAvailable();
                end;
            }
            action(Service)
            {
                ApplicationArea = All;
                Caption = 'Service Vehicle';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = LogSetup;

                trigger OnAction()
                var
                    myInt: Integer;
                begin
                    ServiceVehicle();
                end;
            }
            action(GetMileage)
            {
                ApplicationArea = All;
                Caption = 'Get Mileage';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = Refresh;

                trigger OnAction()
                var
                    myInt: Integer;
                begin
                    GetMileage();
                    Message('Vehicle mileage has been updated based on the latest performance data of responsible employee');
                end;
            }
        }
    }

    var
        workCondition: Record "General value";
        ConditionOfWork: Text;

    trigger OnAfterGetRecord()
    var
        myInt: Integer;
    begin
        workCondition.Reset();
        workCondition.SetRange(Type, workCondition.Type::"Work Condition");
        workCondition.SetRange("Equipment No.", Rec."No.");
        if workCondition.FindLast() then
            ConditionOfWork := workCondition.Description
        else
            ConditionOfWork := '';
    end;

    local procedure DrillDownActionOnPage()
    var
        WorkCondition: Record "General value";

    begin
        WorkCondition.SetRange("Equipment No.", Rec."No.");
        WorkCondition.SetRange(Type, WorkCondition.Type::"Work Condition");
        PAGE.RunModal(50031, WorkCondition);
        CurrPage.Update(false);
    end;

    local procedure MakeAvailable()
    var
        FixedAsset: Record "Fixed Asset";
    begin
        FixedAsset.Reset();
        FixedAsset.SetRange("No.", Rec."No.");
        if FixedAsset.FindFirst() then begin
            FixedAsset."Equipment Status" := FixedAsset."Equipment Status"::Available;
            FixedAsset.Modify();
            Message('Equipment/Vehicle: %1 is now available', Rec."No.");
        end;
    end;

    local procedure ServiceVehicle()
    var
        FixedAsset: Record "Fixed Asset";
        
    begin
        
        if Confirm('Are you sure you want to service this vehicle?', true) then begin
            if FixedAsset.Get(Rec."No.") then begin
                // Update the Next Service At Mileage based on the Service Interval
                Rec."Next Service At Mileage" := Rec."Vehicle Mileage" + Rec."Service Interval";
                Rec."Service Date" := Today();
                Rec.Modify();
                Message('Vehicle has been serviced. Next service at mileage is updated to %1 km', Rec."Next Service At Mileage");
            end else
                Error('Fixed Asset not found.');
        end;
    end;

    local procedure GetMileage()
    var
    PerformanceLine: Record "Performance Line";
    TotalKMCovered: Decimal;
        begin
            PerformanceLine.Reset();
            PerformanceLine.SetRange("Document Type", PerformanceLine."Document Type"::"Performance Monitoring");
            PerformanceLine.SetRange("Employee No.", Rec."Responsible Employee");
            TotalKMCovered := 0;
            if PerformanceLine.FindSet() then
                repeat
                    TotalKMCovered += PerformanceLine."KM Covered";
                until PerformanceLine.Next() = 0;
            //Update that exact value instead of adding to existing mileage:
            //Rec."Vehicle Mileage" := TotalKMCovered;
            //to add to existing mileage instead of replacing it: 
            Rec."Vehicle Mileage" += TotalKMCovered;
            Rec.Modify();
        end;
}