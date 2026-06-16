page 50032 "All Maintenance Job Cards"
{
    Caption = 'All Maintenance Jobs';
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    CardPageId = "Maintenance Job Card";
    SourceTable = "Maintenance Header";
    SourceTableView = WHERE("Document Type" = FILTER("Job Card"));
    Editable = false;

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Posting Date"; Rec."Posting Date")
                {
                    ToolTip = 'Specifies the value of the Posting Date field.', Comment = '%';
                }
                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the value of the No. field.', Comment = '%';
                }
                field("Equipment No."; Rec."Equipment No.")
                {
                    ToolTip = 'Specifies the value of the Equipment No. field.', Comment = '%';
                }
                field("Equipment Name"; Rec."Equipment Name")
                {
                    ToolTip = 'Specifies the value of the Equipment Name field.', Comment = '%';
                }
                field("Equipment Make"; Rec."Equipment Make")
                {
                    ToolTip = 'Specifies the value of the Equipment Make field.', Comment = '%';
                }
                field("Equipment Serial No."; Rec."Equipment Serial No.")
                {
                    ToolTip = 'Specifies the value of the Equipment Serial No. field.', Comment = '%';
                }
                field("Driver No."; Rec."Driver No.")
                {
                    ToolTip = 'Specifies the value of the Driver No. field.', Comment = '%';
                }
                field("Driver Name"; Rec."Driver Name")
                {
                    ToolTip = 'Specifies the value of the Driver Name field.', Comment = '%';
                }
                field("Requester No."; Rec."Requester No.")
                {
                    ToolTip = 'Specifies the value of the Requester No. field.', Comment = '%';
                }
                field("Requester Name"; Rec."Requester Name")
                {
                    ToolTip = 'Specifies the value of the Requester Name field.', Comment = '%';
                }
                field("Prepared by"; Rec."Prepared by")
                {
                    ToolTip = 'Specifies the value of the Prepared by field.', Comment = '%';
                }
                field("Job Status"; Rec."Job Status")
                {
                    ToolTip = 'Specifies the value of the Job Status field.', Comment = '%';
                }
            }
        }
        area(Factboxes)
        {
            part("Attached Documents"; "Document Attachment Factbox")
            {
                ApplicationArea = All;
                Caption = 'Attachments';
                SubPageLink = "Table ID" = CONST(Database::"Maintenance Header"), "No." = FIELD("No.");
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
            action(ActionName)
            {

                trigger OnAction()
                begin

                end;
            }
        }
    }

    trigger OnOpenPage();
    begin
        Rec.SETRANGE("Document Type", Rec."Document Type"::"Job Card");
    end;
}