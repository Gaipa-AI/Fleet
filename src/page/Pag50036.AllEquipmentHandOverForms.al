page 50036 "All Equipment HandOver Forms"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Form Header";
    CardPageId = "Equipment HandOver Form";
    Caption = 'All Equipment HandOver Forms';
    SourceTableView = where("Document Type" = filter("Equipment Hand Over"));


    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the value of the No. field.', Comment = '%';
                }
                field("Date"; Rec."Date")
                {
                    ToolTip = 'Specifies the value of the Date field.', Comment = '%';
                }
                field("Former Driver"; Rec."Former Driver")
                {
                    ToolTip = 'Specifies the value of the Former Driver field.', Comment = '%';
                }
                field("Former Driver Name"; Rec."Former Driver Name")
                {
                    ToolTip = 'Specifies the value of the Former Driver Name field.', Comment = '%';
                }
                field("Assigned Driver"; Rec."Assigned Driver")
                {
                    ToolTip = 'Specifies the value of the Assigned Driver field.', Comment = '%';
                }
                field("Assigned Driver Name"; Rec."Assigned Driver Name")
                {
                    ToolTip = 'Specifies the value of the Assigned Driver Name field.', Comment = '%';
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
                field("Equipment RegNo"; Rec."Equipment RegNo")
                {
                    ToolTip = 'Specifies the value of the Equipment RegNo field.', Comment = '%';
                }
                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies the value of the Status field.', Comment = '%';
                }
            }
        }
        area(Factboxes)
        {

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
}