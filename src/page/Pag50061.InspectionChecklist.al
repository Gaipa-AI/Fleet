page 50061 "Inspection Checklist"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Form Header";

    layout
    {
        area(Content)
        {
            group(General1)
            {
                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the value of the No. field.', Comment = '%';
                    ApplicationArea = All;
                    trigger OnAssistEdit();
                    begin
                        IF Rec.AssistEdit(xRec) THEN
                            CurrPage.UPDATE;
                    end;
                }

                field("Equipment No."; Rec."Equipment No.")
                {
                    ToolTip = 'Specifies the value of the Equipment No. field.', Comment = '%';
                    ApplicationArea = All;
                    Caption = 'Equipment No.';

                    trigger OnValidate()
                    begin
                        if Rec."Equipment No." <> '' then
                            UpdateLastVehicleInspection();
                    end;
                }
                field("Equipment Name"; Rec."Equipment Name")
                {
                    ToolTip = 'Specifies the value of the Equipment Name field.', Comment = '%';
                    ApplicationArea = All;
                    Caption = 'Equipment Name';
                }
                field("Equipment RegNo"; Rec."Equipment RegNo")
                {
                    ToolTip = 'Specifies the value of the Equipment RegNo field.', Comment = '%';
                    ApplicationArea = All;
                    Caption = 'RegNo.';
                }
                field("Equipment Make"; Rec."Equipment Make")
                {
                    ToolTip = 'Specifies the value of the Equipment Make field.', Comment = '%';
                    ApplicationArea = All;
                    Caption = 'Make';
                }
                field("Equipment Type"; Rec."Equipment Type")
                {
                    ToolTip = 'Specifies the value of the Equipment Type field.', Comment = '%';
                    ApplicationArea = All;
                    Caption = 'Equipment Type';
                    Editable = false;
                }
                field("Equipment Model"; Rec."Equipment Model")
                {
                    ToolTip = 'Specifies the value of the Equipment Model field.', Comment = '%';
                    ApplicationArea = All;
                    Caption = 'Model';
                }
                field("Driver No."; Rec."Driver No.")
                {
                    ToolTip = 'Specifies the value of the Driver No. field.', Comment = '%';
                    ApplicationArea = All;
                }
                field("Driver Name"; Rec."Driver Name")
                {
                    ToolTip = 'Specifies the value of the Driver Name field.', Comment = '%';
                    ApplicationArea = All;
                }
                // field("Inspection Type"; Rec."Inspection Type")
                // {
                //     ToolTip = 'Specifies the value of the Inspection Type field.', Comment = '%';
                // }
                field("Current Mileage"; Rec."Week Start Km's")
                {
                    ToolTip = 'Specifies the value of the vehicle current mileage from odometer', Comment = '%';
                    ApplicationArea = All;
                    Caption = 'Current Mileage';

                }
                field("Current Hours";Rec."Current Hours")
                {
                    ApplicationArea = All;
                    ToolTip = 'Current hour mileage of equipment';
                    
                }
                // field("Week End Km's"; Rec."Week End Km's")
                // {
                //     ToolTip = 'Specifies the value of the Week End Km''s field.', Comment = '%';
                //     ApplicationArea = All;
                // }
                // field("Current Mileage"; Rec."Odometer Reading")
                // {
                //     ToolTip = 'Specifies the value of vehicle mileage', Comment = '%';
                //     ApplicationArea = All;

                // }
                field(Department; Rec.Department)
                {
                    ToolTip = 'Specifies the value of the Department field.', Comment = '%';
                    ApplicationArea = All;
                }
                field("Crew Location"; Rec."Crew Location")
                {
                    ToolTip = 'Specifies the value of the Crew Location field.', Comment = '%';
                    ApplicationArea = All;
                }
                
                field(Capacity;Rec.Capacity)
                {
                    ApplicationArea = All;
                    ToolTip = 'Voltage capacity of generator';
                    Visible = IsGenerator;
                    Editable = false;

                }
                field("Service Date";Rec."Service Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Date equipment was last serviced';
                    Editable = false;
                }
                field("Next Service Due";Rec."Next Service Due")
                {
                    ApplicationArea = All;
                    ToolTip = 'Due for servicing in hours';
                    Visible = IsGenerator;
                    Editable = false;
                }
                field("Week Start Date"; Rec."Week Start Date")
                {
                    ToolTip = 'Specifies the value of the Week Start Date field.', Comment = '%';
                    ApplicationArea = All;
                    Caption = 'Inspection Date';
                }
                field("State"; Rec."State")
                {
                    ApplicationArea = All;
                    Caption = 'Vehicle State';
                    Editable = IsEditable;
                }
                // field("User State";Rec."User State")
                // {
                //     ApplicationArea = All;
                //     Caption = 'User State';
                //     Visible = true;
                // }
                field("Last Inspected"; Rec."Last Vehicle Inspection")
                {
                    ApplicationArea = All;
                    ToolTip = 'Date when this vehicle was last inspected';
                    Editable = false;

                }
                field(Technician;Rec.Technician)
                {
                    ApplicationArea = All;
                    ToolTip = 'Inspector or person who inspects this equipment';
                }
                field("Technician's Name";Rec."Technician's Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Inspector or person who inspects this equipment';
                    Editable = false;
                }
            }

            // part(General; "Inspection Checklist Subform")
            // {
            //     Caption = 'General';
            //     ApplicationArea = Basic, Suite;
            //     SubPageLink = "Document No." = FIELD("No."), Sections = filter("General");
            //     Visible = IsGenerator;
            // }
            // part(Engine; "Inspection Checklist Subform")
            // {
            //     Caption = 'Engine';
            //     ApplicationArea = Basic, Suite;
            //     SubPageLink = "Document No." = FIELD("No."), Sections = filter("Engine");
            //     Visible = IsGenerator;
            // }
            // part(Fuel; "Inspection Checklist Subform")
            // {
            //     Caption = 'Fuel';
            //     ApplicationArea = Basic, Suite;
            //     SubPageLink = "Document No." = FIELD("No."), Sections = filter("Fuel");
            //     Visible = IsGenerator;
            // }

 
            // part(Electrical; "Inspection Checklist Subform")
            // {
            //     Caption = 'Electrical';
            //     ApplicationArea = Basic, Suite;
            //     SubPageLink = "Document No." = FIELD("No."), Sections = filter("Electrical");
            //     Visible = IsGenerator;
            // }
            // part(Lubrication; "Inspection Checklist Subform")
            // {
            //     Caption = 'Lubrication';
            //     ApplicationArea = Basic, Suite;
            //     SubPageLink = "Document No." = FIELD("No."), Sections = filter("Lubrication");
            //     Visible = IsGenerator;
            // }
            // part(Mechanical; "Inspection Checklist Subform")
            // {
            //     Caption = 'Mechanical';
            //     ApplicationArea = Basic, Suite;
            //     SubPageLink = "Document No." = FIELD("No."), Sections = filter("Mechanical");
            //     Visible = IsGenerator;
            // }
            // part(Housekeeping; "Inspection Checklist Subform")
            // {
            //     Caption = 'Housekeeping';
            //     ApplicationArea = Basic, Suite;
            //     SubPageLink = "Document No." = FIELD("No."), Sections = filter(Housekeeping);
            //     Visible = IsGenerator;
            // }

            part(WalkAround; "Inspection Checklist Subform")
            {
                Caption = 'Walk Around';
                ApplicationArea = Basic, Suite;
                SubPageLink = "Document No." = FIELD("No."), Sections = filter("Walk around");
                Visible = true;
                
            }
           
            part(UnderBonnet; "Inspection Checklist Subform")
            {
                Caption = 'Under Bonnet';
                ApplicationArea = Basic, Suite;
                SubPageLink = "Document No." = FIELD("No."), Sections = filter("Under Bonnet");
                Visible = true;
            }
            part(InsideVehicle; "Inspection Checklist Subform")
            {
                Caption = 'Inside Vehicle';
                ApplicationArea = Basic, Suite;
                SubPageLink = "Document No." = FIELD("No."), Sections = filter("Inside Vehicle");
                Visible = true;
                
            }
            part(EmergencyEquipment; "Inspection Checklist Subform")
            {
                Caption = 'Emergency Equipment';
                ApplicationArea = Basic, Suite;
                SubPageLink = "Document No." = FIELD("No."), Sections = filter("Emergency Equipment");
                Visible = true;
            }
            part(BeforeSettingOff; "Inspection Checklist Subform")
            {
                Caption = 'Before Setting Off';
                ApplicationArea = Basic, Suite;
                SubPageLink = "Document No." = FIELD("No."), Sections = filter("Before setting off");
                Visible = true;
            }
            group(RoadLicenses)
            {
                Caption = 'Road Licenses';
                field("License Expiry Date"; Rec."License Expiry Date")
                {
                    ToolTip = 'Specifies the value of the Valid Drivers License (exp. Date) field.', Comment = '%';
                }
                field("Next Service at Mileage"; Rec."Next Service at Mileage")
                {
                    ToolTip = 'Specifies the value of the Next Service at Mileage field.', Comment = '%';
                }
                field("Defensive Driving Exp. Date"; Rec."Defensive Driving Exp. Date")
                {
                    ToolTip = 'Specifies the value of the Defensive Driving Exp. Date field.', Comment = '%';
                }
                field("3RD Party Exp. Date"; Rec."3RD Party Exp. Date")
                {
                    ToolTip = 'Specifies the value of the 3RD Party Exp. Date field.', Comment = '%';
                }
            }
        }

        area(Factboxes)
        {
            part("Attached Documents"; "Doc. Attachment List Factbox")
            {
                ApplicationArea = All;
                Caption = 'Attachments';
                SubPageLink = "Table ID" = CONST(Database::"Form Header"), "No." = FIELD("No.");
            }
            systempart(Links; Links)
            {
                ApplicationArea = RecordLinks;
            }
            systempart(Notes; Notes)
            {
                ApplicationArea = Notes;
            }
        }
    }

    actions
    {
        area(Processing)
        {
            //group(Request)
            //{
                action("Comments")
                {
                    Caption = 'Comments';
                    Image = ViewComments;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Purch. Comment Sheet";
                    RunPageLink = "Document Type" = filter("Equipment Inspection"),
                                  "No." = FIELD("No."),
                                  "Document Line No." = CONST(0);
                }
                action(DocAttach)
                {
                    ApplicationArea = All;
                    Caption = 'Attachments';
                    Image = Attach;
                    Promoted = true;
                    PromotedCategory = Process;
                    ToolTip = 'Add a file as an attachment. You can attach images as well as documents.';

                    trigger OnAction()
                    var
                        DocumentAttachmentDetails: Page "Document Attachment Details";
                        RecRef: RecordRef;
                    begin
                        RecRef.GetTable(Rec);
                        DocumentAttachmentDetails.OpenForRecRef(RecRef);
                        DocumentAttachmentDetails.RunModal;
                    end;
                }
                group(CreateSections)
                {
                    Caption = 'Create Section Lines';
                    //Image = CreateDocument;
                    ShowAs = SplitButton;
                    action(createSectionLines)
                    {
                        ApplicationArea = Suite;
                        //Caption = 'Create Section Lines';
                        Caption = 'Vehicle';
                        Image = CreateDocument;
                        Ellipsis = true;
                        Promoted = true;
                        PromotedCategory = Process;
                        ToolTip = 'Create Section Lines for a vehicles';

                        trigger OnAction()
                        begin
                            if Confirm('Are you sure you want to create section Lines?', true) then
                                Rec.GenerateSections1('VEHICLES');
                        end;
                    }
                    action(CreateGen)
                    {
                        ApplicationArea = Suite;
                        //Caption = 'Create Section Lines';
                        Caption = 'Generator';
                        Image = CreateDocument;
                        Promoted = true;
                        Ellipsis = true;
                        PromotedCategory = Process;
                        ToolTip = 'Create Section Lines for a generator';

                        trigger OnAction()
                        begin
                            if Confirm('Are you sure you want to create section Lines?', true) then
                                Rec.GenerateSections1('GENERATORS');
                        end;

                    }
                }
                action(Print)
                {
                    Caption = 'Print';
                    Image = Print;
                    Promoted = true;
                    PromotedCategory = Report;
                    PromotedIsBig = true;

                    trigger OnAction();
                    var
                        ReqnHeader: Record "Form Header";
                        RptStoreReqn: Report "Vehicle Inspection CheckList";
                    begin
                        ReqnHeader.SETRANGE("Document Type", ReqnHeader."Document Type"::"Equipment Inspection");
                        ReqnHeader.SETRANGE("No.", Rec."No.");
                        RptStoreReqn.SETTABLEVIEW(ReqnHeader);
                        RptStoreReqn.RUNMODAL;
                    end;
                }
            //}
        }
    }

    trigger OnAfterGetRecord()
    begin
        if Rec."State" = Rec.State::"Good Condition" then IsEditable := true
        else if Rec."State" = Rec.State::" " then IsEditable := true
        else IsEditable := false;
        
    end;

    trigger OnOpenPage()
    begin 
        // if Rec."Equipment Type" = 'GENERATORS' then IsGenerator := true
        //   else IsGenerator := false;
        // //IsSeen := Rec."Equipment Type" <> 'VEHICLES';
        // if Rec."Equipment Type" = 'VEHICLES' then IsVehicle := true
        //   else IsVehicle := false;
        // CurrPage.UPDATE(true);
    end;
    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Rec."Inspection Type":= Rec."Inspection Type"::Vehicle;
    end;

    trigger OnAfterGetCurrRecord()
    begin
        // if Rec."Equipment Type" = 'GENERATORS' then IsGenerator := true
        //   else IsGenerator := false;
        
        // if Rec."Equipment Type" = 'VEHICLES' then IsVehicle := true
        //   else IsVehicle := false;
        // CurrPage.UPDATE(true);
    end;

    trigger OnModifyRecord(): Boolean
    begin
        UpdateVehicleOdometer();
    end;

    local procedure UpdateLastVehicleInspection()
    var
        PrevChecklist: Record "Form Header";
        LastInspectionDate: Date;
    begin
        if Rec."Equipment No." = '' then
            exit;

        PrevChecklist.Reset();
        PrevChecklist.SetRange("Document Type", PrevChecklist."Document Type"::"Equipment Inspection");
        PrevChecklist.SetRange("Equipment No.", Rec."Equipment No.");
        if Rec."No." <> '' then
            PrevChecklist.SetFilter("No.", '<>%1', Rec."No.");

        LastInspectionDate := 0D;
        if PrevChecklist.FindSet() then
            repeat
                if PrevChecklist."Week Start Date" > LastInspectionDate then
                    LastInspectionDate := PrevChecklist."Week Start Date";
            until PrevChecklist.Next() = 0;

        Rec."Last Vehicle Inspection" := LastInspectionDate;
    end;

    local procedure UpdateVehicleOdometer()
    var
        Vehicle: Record "Fixed Asset";
    begin
        if (Rec."Equipment No." <> '') and (Rec."Week Start Km's" > 0) and Vehicle.Get(Rec."Equipment No.") then
            if Rec."Week Start Km's" > Vehicle."Vehicle Mileage" then begin
                Vehicle."Vehicle Mileage" := Rec."Week Start Km's";
                Vehicle.Modify();
            end;
            if Rec."Week Start Km's" < Vehicle."Vehicle Mileage" then begin
                Message('Current mileage cant be less than previous mileage');
                Error('Invalid mileage');
            end;

            //else Error('Current mileage cant be less than previous mileage');
        if (Rec."Equipment No." <> '') and (Rec."Current Hours" > 0) and Vehicle.Get(Rec."Equipment No.") then
            if Rec."Current Hours" > Vehicle."Current Hours" then begin
                Vehicle."Current Hours" := Rec."Current Hours";
                Vehicle.Modify();
            end;
    end;

    var
        myInt: Integer;
        IsEditable: Boolean;
        IsVehicle : Boolean;
        IsGenerator: Boolean;
        IsSeen: Boolean;
}