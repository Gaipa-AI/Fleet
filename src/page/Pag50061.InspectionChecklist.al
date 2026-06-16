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
            group(General)
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
                field("Inspection Type"; Rec."Inspection Type")
                {
                    ToolTip = 'Specifies the value of the Inspection Type field.', Comment = '%';
                }
                field("Current Mileage"; Rec."Week Start Km's")
                {
                    ToolTip = 'Specifies the value of the vehicle current mileage from odometer', Comment = '%';
                    ApplicationArea = All;
                    Caption = 'Current Mileage';

                    trigger OnValidate()
                    var 
                      Assets : Record "Fixed Asset";
                    begin

                    end;
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
                field("Equipment No."; Rec."Equipment No.")
                {
                    ToolTip = 'Specifies the value of the Equipment No. field.', Comment = '%';
                    ApplicationArea = All;
                    Caption = 'Vehicle No.';

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
                    Caption = 'Vehicle Name';
                }
                field("Equipment RegNo"; Rec."Equipment RegNo")
                {
                    ToolTip = 'Specifies the value of the Equipment RegNo field.', Comment = '%';
                    ApplicationArea = All;
                    Caption = 'Vehicle RegNo.';
                }
                field("Equipment Make"; Rec."Equipment Make")
                {
                    ToolTip = 'Specifies the value of the Equipment Make field.', Comment = '%';
                    ApplicationArea = All;
                    Caption = 'Vehicle Make';
                }
                field("Equipment Type"; Rec."Equipment Type")
                {
                    ToolTip = 'Specifies the value of the Equipment Type field.', Comment = '%';
                    ApplicationArea = All;
                    Caption = 'Vehicle Type';
                    Editable = false;
                }
                field("Equipment Model"; Rec."Equipment Model")
                {
                    ToolTip = 'Specifies the value of the Equipment Model field.', Comment = '%';
                    ApplicationArea = All;
                    Caption = 'Vehicle Model';
                }
                field("Week Start Date"; Rec."Week Start Date")
                {
                    ToolTip = 'Specifies the value of the Week Start Date field.', Comment = '%';
                    ApplicationArea = All;
                    Caption = 'Inspection Date';
                }
                field("State"; Rec.State)
                {
                    ApplicationArea = All;
                    Caption = 'Vehicle State';
                    Editable = IsEditable;

                }
                // field("User ID"; Rec."Prepared by")
                // {
                //     ApplicationArea = All;
                //     Caption = 'User ID';
                // }
                field("Last Inspected"; Rec."Last Vehicle Inspection")
                {
                    ApplicationArea = All;
                    ToolTip = 'Date when this vehicle was last inspected';
                    //Editable = false;

                }
            }
            part(WalkAround; "Inspection Checklist Subform")
            {
                Caption = 'Walk Around';
                ApplicationArea = Basic, Suite;
                SubPageLink = "Document No." = FIELD("No."), Sections = filter("Walk around");
            }
            part(UnderBonnet; "Inspection Checklist Subform")
            {
                Caption = 'Under Bonnet';
                ApplicationArea = Basic, Suite;
                SubPageLink = "Document No." = FIELD("No."), Sections = filter("Under Bonnet");
            }
            part(InsideVehicle; "Inspection Checklist Subform")
            {
                Caption = 'Inside Vehicle';
                ApplicationArea = Basic, Suite;
                SubPageLink = "Document No." = FIELD("No."), Sections = filter("Inside Vehicle");
            }
            part(EmergencyEquipment; "Inspection Checklist Subform")
            {
                Caption = 'Emergency Equipment';
                ApplicationArea = Basic, Suite;
                SubPageLink = "Document No." = FIELD("No."), Sections = filter("Emergency Equipment");
            }
            part(BeforeSettingOff; "Inspection Checklist Subform")
            {
                Caption = 'Before Setting Off';
                ApplicationArea = Basic, Suite;
                SubPageLink = "Document No." = FIELD("No."), Sections = filter("Before setting off");
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
            group(Request)
            {
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
                action(createSectionLines)
                {
                    ApplicationArea = All;
                    Caption = 'Create Section Lines';
                    Image = CreateDocument;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    begin
                        if Confirm('Are you sure you want to create section Lines?', true) then
                            Rec.GenerateSections();
                    end;
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
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        if Rec."State" = Rec.State::"Good Condition" then IsEditable := true
        else IsEditable := false;
        
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

    var
        myInt: Integer;
        IsEditable: Boolean;
}